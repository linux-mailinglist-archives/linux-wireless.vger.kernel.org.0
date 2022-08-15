Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A55927A5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Aug 2022 03:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiHOB5n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Aug 2022 21:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHOB5l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Aug 2022 21:57:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DD9512A90
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 18:57:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27F1uICT1007695, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27F1uICT1007695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 15 Aug 2022 09:56:18 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 15 Aug 2022 09:56:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 15 Aug 2022 09:56:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97]) by
 RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97%5]) with mapi id
 15.01.2375.007; Mon, 15 Aug 2022 09:56:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 12/50] wifi: ath12k: add dp.h
Thread-Topic: [PATCH 12/50] wifi: ath12k: add dp.h
Thread-Index: AQHYrmYhVT/+9aWmK0SqnIzaxO3tva2vM+VA
Date:   Mon, 15 Aug 2022 01:56:29 +0000
Message-ID: <0eabd6c1b3ca4d8a8152ad5b4f3efee6@realtek.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-13-kvalo@kernel.org>
In-Reply-To: <20220812161003.27279-13-kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/8/14_=3F=3F_10:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Saturday, August 13, 2022 12:09 AM
> To: linux-wireless@vger.kernel.org
> Cc: ath12k@lists.infradead.org
> Subject: [PATCH 12/50] wifi: ath12k: add dp.h
> 
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp.h | 2017 ++++++++++++++++++++++++++++++++++
>  1 file changed, 2017 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> new file mode 100644
> index 000000000000..cf9610dffbb8
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/dp.h

[...]

> +
> +struct htt_srng_setup_cmd {
> +	u32 info0;
> +	u32 ring_base_addr_lo;
> +	u32 ring_base_addr_hi;
> +	u32 info1;
> +	u32 ring_head_off32_remote_addr_lo;
> +	u32 ring_head_off32_remote_addr_hi;
> +	u32 ring_tail_off32_remote_addr_lo;
> +	u32 ring_tail_off32_remote_addr_hi;
> +	u32 ring_msi_addr_lo;
> +	u32 ring_msi_addr_hi;
> +	u32 msi_data;
> +	u32 intr_info;
> +	u32 info2;
> +} __packed;
> +

Should they be '__le32' instead of 'u32'?

This struct is used to fill data of ath12k_htc_send(), and the fields of
htc header are __le32: 

struct ath12k_htc_hdr {
	__le32 htc_info;
	__le32 ctrl_info;
} __packed __aligned(4);

If above is correct, some struct(s) related to ath12k_htc_send() have similar problems: 
struct htt_ver_req_cmd
struct htt_ppdu_stats_cfg_cmd
struct htt_rx_ring_selection_cfg_cmd
struct htt_ext_stats_cfg_cmd
struct htt_tx_ring_selection_cfg_cmd  (miss __packed)

--
Ping-Ke

