Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A447F454273
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 09:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhKQIQC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 03:16:02 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:33070 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhKQIQB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 03:16:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637136783; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=a7bo+NdM1bUHbggJutVzsB0KMuaOVg3ZF1q0qM17bbM=; b=xCWE2BTdcvJFiWU4FFYfwntN7Z0BWbzSIEfO0FrcmaVOwUvzFqEHV2FnjnP8B4LXFodTpeuX
 8l5CuEdJ6nycFkJTSiPLo92wKJJOUce8IicozVszf9v0NpInFVe2vCsS3rwefoBzl3bPH/k1
 TcsgA6sn2qdaRAw4RMv1vTmZP0A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6194b98e0a5410021b5013dd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 08:13:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBD0BC4360C; Wed, 17 Nov 2021 08:13:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FEDAC4338F;
        Wed, 17 Nov 2021 08:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9FEDAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ath11k: add support for device recovery for QCA6390
References: <20211116041522.23529-1-quic_wgong@quicinc.com>
        <20211116041522.23529-4-quic_wgong@quicinc.com>
        <1752085.FWK5zBq28I@ripper>
Date:   Wed, 17 Nov 2021 10:12:55 +0200
In-Reply-To: <1752085.FWK5zBq28I@ripper> (Sven Eckelmann's message of "Tue, 16
        Nov 2021 09:15:44 +0100")
Message-ID: <87mtm3dwu0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> On Tuesday, 16 November 2021 05:15:21 CET Wen Gong wrote:
>> Currently ath11k has device recovery logic, it is introduced by this
>> patch "ath11k: Add support for subsystem recovery" which is upstream
>> by
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath11k-bringup&id=3a7b4838b6f6f234239f263ef3dc02e612a083ad.
>
> https://www.kernel.org/doc/html/v5.15/process/submitting-patches.html#describe-your-changes
>
> Please search for "If you want to refer to a specific commit"
> And this commit you referenced is definitely not the upstream commit.
> It was only part of Kalle's repository. The code was only upstreamed
> with commit d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax
> devices").
>
>
> Btw. another thing which I see again and again in these patches:
>
>> --- a/drivers/net/wireless/ath/ath11k/core.h
>> +++ b/drivers/net/wireless/ath/ath11k/core.h
>> @@ -39,6 +39,10 @@
> [...]
>> +       bool is_reset;
>
> https://www.kernel.org/doc/html/v5.15/process/coding-style.html#using-bool
>
> "If a structure has many true/false values, consider consolidating them into a 
> bitfield with 1 bit members, or using an appropriate fixed width type, such as 
> u8."
>
> There are more verbose mails from Linus Torvalds where he points out the 
> problems of bools in structs. See for example struct ath11k_skb_rxcb. At
> the moment, it looks like this:
>
>     struct ath11k_skb_rxcb {
>     	dma_addr_t paddr;
>     	bool is_first_msdu;
>     	bool is_last_msdu;
>     	bool is_continuation;
>     	bool is_mcbc;
>     	bool is_eapol_tkip;
>     	struct hal_rx_desc *rx_desc;
>     	u8 err_rel_src;
>     	u8 err_code;
>     	u8 mac_id;
>     	u8 unmapped;
>     	u8 is_frag;
>     	u8 tid;
>     	u16 peer_id;
>     	u16 seq_no;
>     	struct napi_struct *napi;
>     };
>
> Compiled for IPQ60xx, it would end up as:
>
>     $ pahole ./drivers/net/wireless/ath/ath11k/ath11k.o -C ath11k_skb_rxcb
>     struct ath11k_skb_rxcb {
>             dma_addr_t                 paddr;                /*     0     8 */
>             bool                       is_first_msdu;        /*     8     1 */
>             bool                       is_last_msdu;         /*     9     1 */
>             bool                       is_continuation;      /*    10     1 */
>             bool                       is_mcbc;              /*    11     1 */
>             bool                       is_eapol_tkip;        /*    12     1 */
>     
>             /* XXX 3 bytes hole, try to pack */
>     
>             struct hal_rx_desc *       rx_desc;              /*    16     8 */
>             u8                         err_rel_src;          /*    24     1 */
>             u8                         err_code;             /*    25     1 */
>             u8                         mac_id;               /*    26     1 */
>             u8                         unmapped;             /*    27     1 */
>             u8                         is_frag;              /*    28     1 */
>             u8                         tid;                  /*    29     1 */
>             u16                        peer_id;              /*    30     2 */
>             u16                        seq_no;               /*    32     2 */
>     
>             /* XXX 6 bytes hole, try to pack */
>     
>             struct napi_struct *       napi;                 /*    40     8 */
>     
>             /* size: 48, cachelines: 1, members: 16 */
>             /* sum members: 39, holes: 2, sum holes: 9 */
>             /* last cacheline: 48 bytes */
>     };
>
> After changing it to u8 ....:1 and reorganizing the structure:
>
>     $ pahole drivers/net/wireless/ath/ath11k/ath11k.o -C ath11k_skb_rxcb -R
>     struct ath11k_skb_rxcb {
>             dma_addr_t                 paddr;                /*     0     8 */
>             struct hal_rx_desc *       rx_desc;              /*     8     8 */
>             struct napi_struct *       napi;                 /*    16     8 */
>             u8                         err_rel_src;          /*    24     1 */
>             u8                         err_code;             /*    25     1 */
>             u8                         mac_id;               /*    26     1 */
>             u8                         unmapped;             /*    27     1 */
>             u8                         is_frag;              /*    28     1 */
>             u8                         tid;                  /*    29     1 */
>             u8                         is_first_msdu:1;      /*    30: 0  1 */
>             u8                         is_last_msdu:1;       /*    30: 1  1 */
>             u8                         is_continuation:1;    /*    30: 2  1 */
>             u8                         is_mcbc:1;            /*    30: 3  1 */
>             u8                         is_eapol_tkip:1;      /*    30: 4  1 */
>     
>             /* XXX 3 bits hole, try to pack */
>             /* XXX 1 byte hole, try to pack */
>     
>             u16                        peer_id;              /*    32     2 */
>             u16                        seq_no;               /*    34     2 */
>     
>             /* size: 40, cachelines: 1, members: 16 */
>             /* sum members: 34, holes: 1, sum holes: 1 */
>             /* sum bitfield members: 5 bits, bit holes: 1, sum bit holes: 3 bits */
>             /* padding: 4 */
>             /* last cacheline: 40 bytes */
>     };
>
>
>
> Or ath11k_bus_params:
>
>     $ pahole ./drivers/net/wireless/ath/ath11k/ath11k.o -C ath11k_bus_params
>     struct ath11k_bus_params {
>             bool                       mhi_support;          /*     0     1 */
>             bool                       m3_fw_support;        /*     1     1 */
>             bool                       fixed_bdf_addr;       /*     2     1 */
>             bool                       fixed_mem_region;     /*     3     1 */
>             bool                       static_window_map;    /*     4     1 */
>     
>             /* size: 5, cachelines: 1, members: 5 */
>             /* last cacheline: 5 bytes */
>     };
>
> After changing it to an "u8 ....:1":
>
>     $ pahole ./drivers/net/wireless/ath/ath11k/ath11k.o -C ath11k_bus_params
>     struct ath11k_bus_params {
>             u8                         mhi_support:1;        /*     0: 0  1 */
>             u8                         m3_fw_support:1;      /*     0: 1  1 */
>             u8                         fixed_bdf_addr:1;     /*     0: 2  1 */
>             u8                         fixed_mem_region:1;   /*     0: 3  1 */
>             u8                         static_window_map:1;  /*     0: 4  1 */
>     
>             /* size: 1, cachelines: 1, members: 5 */
>             /* bit_padding: 3 bits */
>             /* last cacheline: 1 bytes */
>     };
>
>
> There are even better examples. ath11k_hw_params will for example take 
> currently 200 bytes. With a little reordering and adjusting of bools,
> it can easily be reduced to 152 bytes. But other structures might
> have more impact because they are used more often.

Yeah, I have been worried about this as well and we should fix this. But
instead of u8 I would prefer to use bool like mt76 uses:

struct mt76_queue_entry {
	union {
		void *buf;
		struct sk_buff *skb;
	};
	union {
		struct mt76_txwi_cache *txwi;
		struct urb *urb;
		int buf_sz;
	};
	u32 dma_addr[2];
	u16 dma_len[2];
	u16 wcid;
	bool skip_buf0:1;
	bool skip_buf1:1;
	bool done:1;
};

I didn't even know using bool is legal until I saw it in mt76.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
