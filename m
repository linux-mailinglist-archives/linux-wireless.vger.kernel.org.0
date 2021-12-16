Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC182477397
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 14:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhLPNvL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 08:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLPNvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 08:51:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB881C061574
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 05:51:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AB30B8242C
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 13:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894F2C36AE5;
        Thu, 16 Dec 2021 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639662668;
        bh=+Ui8+psUwSY1HhMnb2Pw+DoIUwFr/mdGbtqF2GV5jNo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gvHmqy52RN3lK0rpKfJZzr+2f4dLjE1gFJLrOIH2kh1HheR53XZqi8nQ15JXjk/vZ
         zt6GoVb76p1LaGIk2PtCW4LyMwHANi5sg9ja39TetofZYt0UwVe2fkG/OHNrqkpoBu
         uC6JssAl4aMkr5DQrsKhW9bS7E4UqFH6ECRDqy+gisthxeWNCtEOKysU5Wym7nYIxS
         LRyaVvTF64vP9lviqAvkTN1KxBo/pzA+Cws5IW59W7eDum0cimrjChYsgsKWt2paag
         leljiGXqYBnor5WzV5fzHy0sGCZNUhoGoHghDDjN1e8QVMnJZz6fT3sxrC+k8VO86q
         gQ9qFm3NASzsA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath11k: report tx bitrate for iw wlan station dump
References: <20211213102723.4857-1-quic_wgong@quicinc.com>
        <87y24ngjaa.fsf@codeaurora.org>
        <2aecb0d6-6710-d460-4505-0594ae7a55a2@quicinc.com>
Date:   Thu, 16 Dec 2021 15:51:05 +0200
In-Reply-To: <2aecb0d6-6710-d460-4505-0594ae7a55a2@quicinc.com> (Wen Gong's
        message of "Thu, 16 Dec 2021 18:41:55 +0800")
Message-ID: <871r2cd5fa.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> On 12/15/2021 1:58 AM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> writes:
> ...
>> I briefly tested this and tx rate didn't look correct to me:
>>
>> $ iw wlan0 link
>> Connected to xx (on wlan0)
>> 	SSID: <censored>
>> 	freq: 2442
>> 	RX: 8838 bytes (80 packets)
>> 	TX: 1551 bytes (15 packets)
>> 	signal: -104 dBm
>> 	rx bitrate: 39.0 MBit/s MCS 4
>> 	tx bitrate: (unknown) MCS 253
> Yes, I reproduced this strange tx bitrate value after try with 3 AP.
> AP1: tx bitrate:=C2=A0=C2=A0=C2=A0=C2=A0 144.4 MBit/s VHT-MCS 7 short GI =
VHT-NSS 2
> AP2: tx bitrate:=C2=A0=C2=A0=C2=A0=C2=A0 286.7 MBit/s HE-MCS 11 HE-NSS 2 =
HE-GI 0 HE-DCM 0
> AP3: tx bitrate:=C2=A0=C2=A0=C2=A0=C2=A0 (unknown) MCS 254
> I will check it.
>>
>> I guess the signal isn't correct either, are you planning to fix it also
>> at some point?
> I have sent patch to fix signal:
> [v2] ath11k: add signal report to mac80211 for QCA6390 and WCN6855
> https://patchwork.kernel.org/project/linux-wireless/patch/20211216070535.=
31732-1-quic_wgong@quicinc.com/
>
> The new signal value of "iw wlan station dump":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signal:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 -50 [-51, -55] dBm

Great, thank you.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
