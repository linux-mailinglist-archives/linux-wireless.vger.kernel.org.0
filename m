Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE713201A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 08:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgAGHAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 02:00:24 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:29598 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgAGHAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 02:00:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578380424; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nwrXD85GM7JS1yms6oB4ZFld/jMasK8YbTRh3BalevY=;
 b=g1IpxB8pq28CneHjQ3mU/hTaZcLTYRlvD2J6ybv29VTVCA//DfWlYeFOHwUcJrXYOEprPCRX
 fKCJ7/APpWLIkf5V2OnyxZ/N1O23Obw7PDSkOzsr2BKDghy1ipct4q6xPt2X2a8i+UtGnpqi
 jp15zGFB1qML1MDOl/3gz+JCu1o=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e142c86.7f6570844928-smtp-out-n03;
 Tue, 07 Jan 2020 07:00:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83328C447A3; Tue,  7 Jan 2020 07:00:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BDF5C433CB;
        Tue,  7 Jan 2020 07:00:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Jan 2020 12:30:19 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Vikas Patel <vikpatel@codeaurora.org>
Subject: Re: [PATCH] ath10k: avoid consecutive OTP download to reduce boot
 time
In-Reply-To: <1578378195-25780-1-git-send-email-mkenna@codeaurora.org>
References: <1578378195-25780-1-git-send-email-mkenna@codeaurora.org>
Message-ID: <f1b4007f9d7e882c4ed2db67dc64cc96@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-07 11:53, Maharaja Kennadyrajan wrote:

[Maha]: Please ignore/drop this duplicate patch as I sent it already.
Regret for inconvenience caused.


> From: Vikas Patel <vikpatel@codeaurora.org>
> 
> Currently, OTP is downloaded twice in case of "pre-cal-dt"
> and "pre-cal-file" to fetch the board ID and takes around
> ~2 sec more boot uptime.
> 
> First OTP download happens in "ath10k_core_probe_fw" and
> second in ath10k_core_start. First boot does not need OTP
> download in core start when valid board id acquired.
> 
> The second OTP download is required upon core stop/start.
> 
> This patch skips the OTP download when first OTP download
> has acquired a valid board id. This patch also marks board
> id invalid in "ath10k_core_stop", which will force the OTP
> download in ath10k_core_start and fetches valid board id.
> 
> Tested HW: QCA9984
> Tested FW: 10.4-3.6-00104
> 
> Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c
> b/drivers/net/wireless/ath/ath10k/core.c
> index 5ec16ce..8fef991 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -874,6 +874,13 @@ static int
> ath10k_core_get_board_id_from_otp(struct ath10k *ar)
>  		return -ENODATA;
>  	}
> 
> +	if (ar->id.bmi_ids_valid) {
> +		ath10k_dbg(ar, ATH10K_DBG_BOOT,
> +			   "boot already acquired valid otp board id,skip download,
> board_id %d chip_id %d\n",
> +			   ar->id.bmi_board_id, ar->id.bmi_chip_id);
> +		goto skip_otp_download;
> +	}
> +
>  	ath10k_dbg(ar, ATH10K_DBG_BOOT,
>  		   "boot upload otp to 0x%x len %zd for board id\n",
>  		   address, ar->normal_mode_fw.fw_file.otp_len);
> @@ -921,6 +928,8 @@ static int
> ath10k_core_get_board_id_from_otp(struct ath10k *ar)
>  	ar->id.bmi_board_id = board_id;
>  	ar->id.bmi_chip_id = chip_id;
> 
> +skip_otp_download:
> +
>  	return 0;
>  }
> 
> @@ -2863,6 +2872,8 @@ void ath10k_core_stop(struct ath10k *ar)
>  	ath10k_htt_tx_stop(&ar->htt);
>  	ath10k_htt_rx_free(&ar->htt);
>  	ath10k_wmi_detach(ar);
> +
> +	ar->id.bmi_ids_valid = false;
>  }
>  EXPORT_SYMBOL(ath10k_core_stop);
