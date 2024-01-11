Return-Path: <linux-wireless+bounces-1724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192582B293
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D111C225AA
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4B44CE09;
	Thu, 11 Jan 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmjGXbOK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F354CB3C
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3879DC433F1;
	Thu, 11 Jan 2024 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704989784;
	bh=586IbbjpftFDYfmI3BMiCS90jeVviDYs5I9sZzMsMyc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lmjGXbOK+8pKz6/XdJ0Nh46R9sVv4Wqjy8w7QFxuFZDhZ7vub6lcmTnYN3SxHkPu8
	 N6G/3lM6cAl4YRdJz7UmUxxIBUqlpHgOgrX8cIPw5mrbOcDNCAj3gK4lN3BEQVmiNi
	 XaNx1FkBf6PAEC+wYpyanX27WhtyYqg0y6oUT/Wf0wSApf9cch5E/DNo0hy7bJvnZh
	 gYkSWkw2Cg+rNCY//OrQBid3a3ltJD+lIy++HqxHFoj+SMLJ92Zt1CxbZjUaIi9XDb
	 p+/M0MiSURqZk3C1+Cg70W78aeQBebofzLV2F8CC5imXIhstBNdXkQdgUv+Xi1iobP
	 7ZXJl3DcqnGog==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: add processing for TWT enable event
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240103050926.14115-2-quic_lingbok@quicinc.com>
References: <20240103050926.14115-2-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170498978118.916301.14993323516499040896.kvalo@kernel.org>
Date: Thu, 11 Jan 2024 16:16:23 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> When ath12k send TWT enable command to firmware, firmware will return a TWT
> enable event to ath12k. Through the analysis of TWT enable event status, we
> can easily obtain the status of TWT enable command. It can be more
> convenient to debug TWT.
> 
> This patch works with WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Fails to compile:

drivers/net/wireless/ath/ath12k/wmi.c: In function 'ath12k_wmi_twt_enable_event':
drivers/net/wireless/ath/ath12k/wmi.c:6675:48: error: passing argument 2 of 'ath12k_wmi_tlv_parse_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
 6675 |         tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
      |                                             ~~~^~~~~~
      |                                                |
      |                                                unsigned char *
drivers/net/wireless/ath/ath12k/wmi.c:367:44: note: expected 'struct sk_buff *' but argument is of type 'unsigned char *'
  367 |                            struct sk_buff *skb, gfp_t gfp)
      |                            ~~~~~~~~~~~~~~~~^~~
drivers/net/wireless/ath/ath12k/wmi.c:6675:14: error: too many arguments to function 'ath12k_wmi_tlv_parse_alloc'
 6675 |         tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/wmi.c:366:1: note: declared here
  366 | ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/wmi.c: In function 'ath12k_wmi_twt_disable_event':
drivers/net/wireless/ath/ath12k/wmi.c:6704:48: error: passing argument 2 of 'ath12k_wmi_tlv_parse_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
 6704 |         tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
      |                                             ~~~^~~~~~
      |                                                |
      |                                                unsigned char *
drivers/net/wireless/ath/ath12k/wmi.c:367:44: note: expected 'struct sk_buff *' but argument is of type 'unsigned char *'
  367 |                            struct sk_buff *skb, gfp_t gfp)
      |                            ~~~~~~~~~~~~~~~~^~~
drivers/net/wireless/ath/ath12k/wmi.c:6704:14: error: too many arguments to function 'ath12k_wmi_tlv_parse_alloc'
 6704 |         tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/wmi.c:366:1: note: declared here
  366 | ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[7]: *** [scripts/Makefile.build:243: drivers/net/wireless/ath/ath12k/wmi.o] Error 1
make[7]: *** Waiting for unfinished jobs....
make[6]: *** [scripts/Makefile.build:480: drivers/net/wireless/ath/ath12k] Error 2
make[5]: *** [scripts/Makefile.build:480: drivers/net/wireless/ath] Error 2
make[4]: *** [scripts/Makefile.build:480: drivers/net/wireless] Error 2
make[3]: *** [scripts/Makefile.build:480: drivers/net] Error 2
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[1]: *** [/home/kvalo/projects/atheros/ath10k/src/ath/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

2 patches set to Changes Requested.

13509671 [1/2] wifi: ath12k: add processing for TWT enable event
13509673 [2/2] wifi: ath12k: add processing for TWT disable event

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240103050926.14115-2-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


