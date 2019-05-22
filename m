Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA325B9C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2019 03:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfEVBUb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 May 2019 21:20:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEVBUa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 May 2019 21:20:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so216337plo.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2019 18:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CpB65cDLGq7XzI4hbeNnxT0sjgfejrvYYgurc14l3FA=;
        b=foLC0zWFki8g626LWwoIm9P7Y/sPGp9D7pwphRKciHL6EDPV7VvdPAFbJFCRNQzxgt
         4zymNebs1ix8ktIUvErWLhKWi+MG87x45xFAIg6cs61grXFN6YN9iZBRpxBBZPkBWap0
         24e4MeuUEbhdpeTjiFwxzYZh/sVSoLzd7F2WLaf5R10vP0dzeA5IR4zjgU2Dcmrvmyfy
         7zSoYMzfO++/nFWCyuB5c3B0gDizywhcQyAtNP+rigD6o35M6lM32H7v1HpEAyCvoohN
         5MlWcJqnxiPmhT+d7L2R2YuYB5m2TKHxlFWHyaQRJHRk8GGqhPdNXAzFLW78Oa2Ba9nU
         rvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CpB65cDLGq7XzI4hbeNnxT0sjgfejrvYYgurc14l3FA=;
        b=XnZtgGWZ4l3rsD/yovml0EyfJTqj+8aciHVwrpHJN3gN2M5UrM6yppS0NjKoQ/ZcgN
         tXH/R/SHA58wf0fby+Ds1vbNBiJNQ5/rOxu/D3NFquPo+ckcqvP58l/eb+uWEUlLjVyM
         lkluSmxB6riD1iPg4w32dd0XAqoN9bEljjLyh5leJs7H2T0PikOa5HUeIpu3vPjyVpXp
         JIQs9oMV4hRo4TBkRnoXIIEyCIML1ABX3piKK39fN7wtmRafh8qfsunleWJ7OQw1YSu+
         KkigT/hsrWE4LBnHq4c7owVYQxMPr6wPastqoWLZKMDHnN/kjUaEh7uR3gzuUQdm0NZD
         u1+w==
X-Gm-Message-State: APjAAAWuFbNvOrLpaEq7R9ZbfeO7Ao8Lr+zarhTk1Z6MTRegfWkPMOz8
        vguW5ap2aDyiNqFkucbWa4YEofDItQc=
X-Google-Smtp-Source: APXvYqyZhWUzzp4/O4aq7qAxGkILoAxGI3ODU/VcMssF5wW4SifccjkV/WVJLbKw8ja9JMyfVqxQKw==
X-Received: by 2002:a17:902:e00f:: with SMTP id ca15mr86084238plb.76.1558488029511;
        Tue, 21 May 2019 18:20:29 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s66sm30146973pfb.37.2019.05.21.18.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 18:20:28 -0700 (PDT)
Date:   Tue, 21 May 2019 18:20:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ath10k: update HOST capability qmi message
Message-ID: <20190522012026.GS31438@minitux>
References: <20190204115555.17052-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204115555.17052-1-govinds@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon 04 Feb 03:55 PST 2019, Govind Singh wrote:

> HOST capability interface data structures are updated
> in HL3.1 fw version. Update the qmi host capability
> members for compatibility across different firmware
> versions.
> Since this change breaks backward compatibility with
> HL2.0 fw, HL2.0 fw upgrade to WLAN.HL.2.0-01617-QCAHLSWMTPLZ-1
> or later version is required.
> 

Sorry for not objecting earlier, I confused this with the "msa info req
rejected: 90" error that we see on some 845 devices.

Given that the wlan firmware is signed there's no way for people in the
community to upgrade their firmware, until such version has propagated
through the official channels for the specific device.
As such this patch inhibits the ability of bringing up wifi on devices
such as the Lenovo Yoga C630.


Is there any way we can detect if we're using the "old" firmware?

Regards,
Bjorn

> Testing:
>         Tested on QCS404 platform(WCN3990 HW).
>         Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1,
>                    WLAN.HL.2.0-01617-QCAHLSWMTPLZ-1
> ---
>  .../net/wireless/ath/ath10k/qmi_wlfw_v01.c    | 229 +++++++++++++++++-
>  .../net/wireless/ath/ath10k/qmi_wlfw_v01.h    |  34 ++-
>  2 files changed, 257 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c b/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c
> index ba79c2e4aed6..4102f7b0b5c3 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c
> @@ -1763,14 +1763,239 @@ struct qmi_elem_info wlfw_host_cap_req_msg_v01_ei[] = {
>  					   daemon_support_valid),
>  	},
>  	{
> -		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.data_type      = QMI_UNSIGNED_4_BYTE,
>  		.elem_len       = 1,
> -		.elem_size      = sizeof(u8),
> +		.elem_size      = sizeof(u32),
>  		.array_type     = NO_ARRAY,
>  		.tlv_type       = 0x10,
>  		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
>  					   daemon_support),
>  	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x11,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   wake_msi_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_4_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u32),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x11,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   wake_msi),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x12,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   gpios_valid),
> +	},
> +	{
> +		.data_type      = QMI_DATA_LEN,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u32),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x12,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   gpios_len),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_4_BYTE,
> +		.elem_len       = QMI_WLFW_MAX_NUM_GPIO_V01,
> +		.elem_size      = sizeof(u32),
> +		.array_type     = VAR_LEN_ARRAY,
> +		.tlv_type       = 0x12,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   gpios),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x13,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   nm_modem_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x13,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   nm_modem),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x14,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   bdf_support_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x14,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   bdf_support),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x15,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   bdf_cache_support_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x15,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   bdf_cache_support),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x16,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   m3_support_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x16,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   m3_support),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x17,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   m3_cache_support_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x17,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   m3_cache_support),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x18,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   cal_filesys_support_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x18,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   cal_filesys_support),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x19,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   cal_cache_support_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x19,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   cal_cache_support),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x1A,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   cal_done_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x1A,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   cal_done),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x1B,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   mem_bucket_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_4_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u32),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x1B,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   mem_bucket),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x1C,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   mem_cfg_mode_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x1C,
> +		.offset         = offsetof(struct wlfw_host_cap_req_msg_v01,
> +					   mem_cfg_mode),
> +	},
>  	{}
>  };
>  
> diff --git a/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h b/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
> index c5e3870b8871..ff668f5d8afd 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
> +++ b/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
> @@ -553,12 +553,38 @@ struct wlfw_mac_addr_resp_msg_v01 {
>  #define WLFW_MAC_ADDR_RESP_MSG_V01_MAX_MSG_LEN 7
>  extern struct qmi_elem_info wlfw_mac_addr_resp_msg_v01_ei[];
>  
> +#define QMI_WLFW_MAX_NUM_GPIO_V01 32
>  struct wlfw_host_cap_req_msg_v01 {
>  	u8 daemon_support_valid;
> -	u8 daemon_support;
> -};
> -
> -#define WLFW_HOST_CAP_REQ_MSG_V01_MAX_MSG_LEN 4
> +	u32 daemon_support;
> +	u8 wake_msi_valid;
> +	u32 wake_msi;
> +	u8 gpios_valid;
> +	u32 gpios_len;
> +	u32 gpios[QMI_WLFW_MAX_NUM_GPIO_V01];
> +	u8 nm_modem_valid;
> +	u8 nm_modem;
> +	u8 bdf_support_valid;
> +	u8 bdf_support;
> +	u8 bdf_cache_support_valid;
> +	u8 bdf_cache_support;
> +	u8 m3_support_valid;
> +	u8 m3_support;
> +	u8 m3_cache_support_valid;
> +	u8 m3_cache_support;
> +	u8 cal_filesys_support_valid;
> +	u8 cal_filesys_support;
> +	u8 cal_cache_support_valid;
> +	u8 cal_cache_support;
> +	u8 cal_done_valid;
> +	u8 cal_done;
> +	u8 mem_bucket_valid;
> +	u32 mem_bucket;
> +	u8 mem_cfg_mode_valid;
> +	u8 mem_cfg_mode;
> +};
> +
> +#define WLFW_HOST_CAP_REQ_MSG_V01_MAX_MSG_LEN 189
>  extern struct qmi_elem_info wlfw_host_cap_req_msg_v01_ei[];
>  
>  struct wlfw_host_cap_resp_msg_v01 {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
