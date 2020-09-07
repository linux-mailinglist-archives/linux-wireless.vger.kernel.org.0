Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B925F7A1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgIGKRl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 06:17:41 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:54362
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728808AbgIGKR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 06:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599473846;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=01VERSWzbigyHGbBCIA/Dqvk0+zsJz0J9iMkJIMgviA=;
        b=kIWOrjBrc8iRrKrdua9bcuWw3ptT07D7bDhfKVZE8oNbgvtW6nKiyAn+9NfDk0nW
        TEyvYJWFC+6hGpFUgJLx49a89fO/ta7nvSqkSuyIssiqsEIUDp8BaVyOnpVVJ9bXUdn
        N7Mdv9m3wC8IbCXt1tMpFb8bjk7niYZGkfpqvcIU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599473846;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=01VERSWzbigyHGbBCIA/Dqvk0+zsJz0J9iMkJIMgviA=;
        b=oaULAF/Uy8lO56Wz6fVqUvhog8zsvlNY4vwkfB/T95va+9hBLwtu6lj1YE2pXV9D
        FICBDloEaJ6h1q1cyZnkZM4eB4PBCNU0w5BzF/4a39Tvl98T6LhhqwjsWw3/TNKuW5A
        G+ZhOdbUkd3z4JvCdCi4fP+qUAim2UXGKo/vciWw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EDECC2BB59
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath11k@lists.infradead.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath11k: cold boot calibration support
References: <1594372049-31480-1-git-send-email-ssreeela@codeaurora.org>
Date:   Mon, 7 Sep 2020 10:17:26 +0000
In-Reply-To: <1594372049-31480-1-git-send-email-ssreeela@codeaurora.org>
        (Sowmiya Sree Elavalagan's message of "Fri, 10 Jul 2020 14:37:29
        +0530")
Message-ID: <0101017468120799-8c9b63ff-c336-49da-a567-e0dea78382fc-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SES-Outgoing: 2020.09.07-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> writes:

> From: Govindaraj Saminathan <gsamin@codeaurora.org>
>
> cold boot calibration is the process to calibrate all the channels
> during the boot-up to avoid the calibration delay during the
> channel change.
> During the boot-up, firmware started with mode =E2=80=9Ccold_boot_calibra=
tion=E2=80=9D
> Firmware calibrate all channels and generate CalDb(DDR).
> Subsequent WIFI ON will reuse the same CalDb.
> Firmware restarted with Mission mode to continue the normal operation.
>
> caldb memory address send to firmware through the QMI message.Firmware
> use this address to store the caldb data and use it until next reboot.
>
> This will give the improvement during the channel change. But it is
> increasing the boot-up time(up to 15sec depend on number of radios).
> So if the user want to reduce the boot-up time and accepting for channel
> change delay, user can disable this feature using the module param
> cold_boot_cal =3D0.
>
> Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
> Co-developed-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>

Please add a Tested-on tag.

What hardware does support this feature? I guess QCA6390 does not? So I won=
der
should we only enable this on hardware which we know supports this? For the
rest we would just give a warning and not enable the feature. And to do tha=
t we
would have a boolean for  each hardware in hw_params.

> +static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *a=
b)
> +{
> +	int timeout;
> +	int ret;
> +
> +	ret =3D ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_COLD_BOOT);
> +	if (ret < 0) {
> +		ath11k_warn(ab, "qmi failed to send wlan fw mode:%d\n", ret);
> +		return ret;
> +	}
> +
> +	ath11k_warn(ab, "Coldboot calibration wait started\n");

This should be a debug message.

> +	timeout =3D wait_event_timeout(ab->qmi.cold_boot_waitq,
> +				     (ab->qmi.cal_done  =3D=3D 1),
> +				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
> +	if (timeout <=3D 0) {
> +		ath11k_warn(ab, "Coldboot Calibration timed out\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	ath11k_warn(ab, "Coldboot calibration wait ended\n");

And this too.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
