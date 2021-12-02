Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56846603C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 10:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353491AbhLBJWD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 04:22:03 -0500
Received: from m140-81.mailgun.net ([159.135.140.81]:24292 "EHLO
        m140-81.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbhLBJWD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 04:22:03 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2021 04:22:02 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk;
 q=dns/txt; s=s1; t=1638436720; h=To: References: Message-Id:
 Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: Subject:
 Mime-Version: Content-Type: Sender;
 bh=2vOVk68Ph++JwLUuZn4K2WTAKDYQG6OoLbjPJyPmMwo=; b=gFXnUdjykXoOMFWYhkJ+2hDuzuNRsGUCLdmqdDITmja05GagyFbb0FhAvyiIvdZTyoTsLj6F
 AYXnC0araNTHnCErnWSvt/YPQ7FHohwCvr4Va5jzUtzezaEIFOKy5Ng1Rqy037Rp4wQKYUm9
 3t/Sf8yn890pTvMfiic1qaCGQYKDrYx343gR4ahx9rS6SANRxloWtSXKpYTGKOjswd4mQilh
 WC4+7zS0bz7s8PCU+oyXd0RJQchO9lU4XecNPBfA5OcfCcWfWlP4NP5IIKTffr2r7jemNFjl
 aAtiJrLfweO4SFI3LYrl8FycsqABXF5ecQi2kSPu2Qg0NUgsmSxUyQ==
X-Mailgun-Sending-Ip: 159.135.140.81
X-Mailgun-Sid: WyJkZGUwZCIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiZTM3MjAiXQ==
Received: from mail.hewittfamily.org.uk (<unknown> [87.200.95.144]) by
 smtp-out-n04.prod.eu-central-1.postgun.com with SMTP id
 61a88e40ce333ed70fe662cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Dec 2021 09:13:36
 GMT
Sender: andrew@hewittfamily.org.uk
Received: from [172.16.20.20] (unknown [87.200.95.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.hewittfamily.org.uk (Postfix) with ESMTPSA id 588F565FF5C;
        Thu,  2 Dec 2021 13:13:34 +0400 (+04)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3] ath10k: Fix the MTU size on QCA9377 SDIO
From:   Christian Hewitt <andrew@hewittfamily.org.uk>
In-Reply-To: <87sfvcl7t0.fsf@codeaurora.org>
Date:   Thu, 2 Dec 2021 13:13:33 +0400
Cc:     Fabio Estevam <festevam@denx.de>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, wgong@codeaurora.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFDFA699-65BD-47AC-852D-09ABF44567BD@hewittfamily.org.uk>
References: <20211124131047.713756-1-festevam@denx.de>
 <87sfvcl7t0.fsf@codeaurora.org>
To:     Kalle Valo <kvalo@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Synology-Spam-Status: score=0.399, required 5, MID_RHS_MATCH_FROM 0, FROM_HAS_DN 0, TO_DN_SOME 0, MV_CASE 0.5, TO_MATCH_ENVRCPT_ALL 0, MIME_GOOD -0.1, __THREADED 0, RCPT_COUNT_FIVE 0, RCVD_COUNT_ZERO 0, FROM_EQ_ENVFROM 0, MIME_TRACE 0, __NOT_SPOOFED 0, __BODY_URI_ONLY 0, __HDRS_LCASE_KNOWN 0, NO_RECEIVED -0.001
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 1 Dec 2021, at 6:27 pm, Kalle Valo <kvalo@kernel.org> wrote:
>=20
> Fabio Estevam <festevam@denx.de> writes:
>=20
>> On an imx6dl-pico-pi board with a QCA9377 SDIO chip, simply trying to
>> connect via ssh to another machine causes:
>>=20
>> [   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, =
dropping: -12
>> [   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
>> [   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>> [   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, =
dropping: -12
>> [   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
>> [   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>>=20
>> , leading to an ssh connection failure.
>>=20
>> One user inspected the size of frames on Wireshark and reported
>> the followig:
>>=20
>> "I was able to narrow the issue down to the mtu. If I set the mtu for
>> the wlan0 device to 1486 instead of 1500, the issue does not happen.
>>=20
>> The size of frames that I see on Wireshark is exactly 1500 after
>> setting it to 1486."
>>=20
>> Clearing the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE avoids the problem and
>> the ssh command works successfully after that.
>>=20
>> Introduce a 'credit_size_workaround' field to ath10k_hw_params for
>> the QCA9377 SDIO, so that the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE
>> is not set in this case.
>>=20
>> Tested with QCA9377 SDIO with firmware =
WLAN.TF.1.1.1-00061-QCATFSWPZ-1.
>>=20
>> Fixes: 2f918ea98606 ("ath10k: enable alt data of TX path for sdio")
>> Signed-off-by: Fabio Estevam <festevam@denx.de>
>> ---
>> Changes since v2:
>> - Set the credit_size_workaround field as true for QCA9377 SDIO.
>>=20
>> drivers/net/wireless/ath/ath10k/core.c | 4 +++-
>> drivers/net/wireless/ath/ath10k/hw.h   | 3 +++
>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/wireless/ath/ath10k/core.c =
b/drivers/net/wireless/ath/ath10k/core.c
>> index 72a366aa9f60..8a325ae97b0e 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.c
>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>> @@ -571,6 +571,7 @@ static const struct ath10k_hw_params =
ath10k_hw_params_list[] =3D {
>> 		.ast_skid_limit =3D 0x10,
>> 		.num_wds_entries =3D 0x20,
>> 		.uart_pin_workaround =3D true,
>> +		.credit_size_workaround =3D true,
>=20
> I prefer to have also the false cases for every hardware so in the
> pending branch I added those:
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=3D=
pending&id=3Dafbf52bffb36bc25e7a1e81e1f975bb75696d3c8

^ for the patch in the pending branch, tested with an Amlogic S905D
TV box with QCA9377 SDIO module:

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

