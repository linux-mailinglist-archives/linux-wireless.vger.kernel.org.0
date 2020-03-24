Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE028191292
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 15:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCXOO0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 10:14:26 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37058 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbgCXOOZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 10:14:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585059264; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=D0tDkkn7yvngL5blqt4Sx3OwfBCinbjELusDX5Nb7E0=;
 b=ffif3vYm/Qd7PrDuJWKO93gxsGlNxJZroeApJljFOI0ATRX7WGi4O/0fAYvUwiD/o3i0Xz2O
 J9Z05ih9PHoMNsfjb6uSDOzAJAJiOf8c7FYX0nAZELunWFHzPkkv808qpTLll1eLTHwE/5SA
 rNYk+3py1xfAy1Bd7CgDewHCkao=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7a15ad.7f3a66449b58-smtp-out-n03;
 Tue, 24 Mar 2020 14:14:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84AE6C433CB; Tue, 24 Mar 2020 14:14:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 928C0C433D2;
        Tue, 24 Mar 2020 14:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 928C0C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] dt-bindings: ath10k: Add wifi-firmware subnode for
 wifi node
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585054044-18667-2-git-send-email-pillair@codeaurora.org>
References: <1585054044-18667-2-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200324141404.84AE6C433CB@smtp.codeaurora.org>
Date:   Tue, 24 Mar 2020 14:14:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> Add a wifi-firmware subnode for the wifi node.
> This wifi-firmware subnode is needed for the
> targets which do not support TrustZone.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>

Fails to build and has warnings. How did you test this?

drivers/net/wireless/ath/ath10k/qmi.c: In function 'ath10k_qmi_msa_mem_info_send_sync_msg':
drivers/net/wireless/ath/ath10k/qmi.c:160:23: error: 'struct ath10k_qmi' has no member named 'msa_pa'
  max_mapped_addr = qmi->msa_pa + qmi->msa_mem_size;
                       ^~
drivers/net/wireless/ath/ath10k/qmi.c:160:37: error: 'struct ath10k_qmi' has no member named 'msa_mem_size'
  max_mapped_addr = qmi->msa_pa + qmi->msa_mem_size;
                                     ^~
drivers/net/wireless/ath/ath10k/qmi.c:163:41: error: 'struct ath10k_qmi' has no member named 'msa_mem_size'
   if (resp.mem_region_info[i].size > qmi->msa_mem_size ||
                                         ^~
drivers/net/wireless/ath/ath10k/qmi.c:165:48: error: 'struct ath10k_qmi' has no member named 'msa_pa'
       resp.mem_region_info[i].region_addr < qmi->msa_pa ||
                                                ^~
make[5]: *** [drivers/net/wireless/ath/ath10k/qmi.o] Error 1
make[5]: *** Waiting for unfinished jobs....
In file included from ./include/linux/byteorder/little_endian.h:5,
                 from ./arch/x86/include/uapi/asm/byteorder.h:5,
                 from ./include/asm-generic/bitops/le.h:6,
                 from ./arch/x86/include/asm/bitops.h:395,
                 from ./include/linux/bitops.h:29,
                 from ./include/linux/kernel.h:12,
                 from ./include/linux/clk.h:13,
                 from drivers/net/wireless/ath/ath10k/snoc.c:6:
drivers/net/wireless/ath/ath10k/snoc.c: In function 'ath10k_msa_dump_memory':
drivers/net/wireless/ath/ath10k/snoc.c:1424:54: error: 'struct ath10k_qmi' has no member named 'msa_va'
  hdr->start = cpu_to_le32((unsigned long)ar_snoc->qmi->msa_va);
                                                      ^~
./include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
 #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                   ^
drivers/net/wireless/ath/ath10k/snoc.c:1424:15: note: in expansion of macro 'cpu_to_le32'
  hdr->start = cpu_to_le32((unsigned long)ar_snoc->qmi->msa_va);
               ^~~~~~~~~~~
drivers/net/wireless/ath/ath10k/snoc.c:1425:40: error: 'struct ath10k_qmi' has no member named 'msa_mem_size'
  hdr->length = cpu_to_le32(ar_snoc->qmi->msa_mem_size);
                                        ^~
./include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
 #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                   ^
drivers/net/wireless/ath/ath10k/snoc.c:1425:16: note: in expansion of macro 'cpu_to_le32'
  hdr->length = cpu_to_le32(ar_snoc->qmi->msa_mem_size);
                ^~~~~~~~~~~
drivers/net/wireless/ath/ath10k/snoc.c:1427:40: error: 'struct ath10k_qmi' has no member named 'msa_mem_size'
  if (current_region->len < ar_snoc->qmi->msa_mem_size) {
                                        ^~
drivers/net/wireless/ath/ath10k/snoc.c:1428:27: error: 'struct ath10k_qmi' has no member named 'msa_va'
   memcpy(buf, ar_snoc->qmi->msa_va, current_region->len);
                           ^~
drivers/net/wireless/ath/ath10k/snoc.c:1430:41: error: 'struct ath10k_qmi' has no member named 'msa_mem_size'
        current_region->len, ar_snoc->qmi->msa_mem_size);
                                         ^~
drivers/net/wireless/ath/ath10k/snoc.c:1432:27: error: 'struct ath10k_qmi' has no member named 'msa_va'
   memcpy(buf, ar_snoc->qmi->msa_va, ar_snoc->qmi->msa_mem_size);
                           ^~
drivers/net/wireless/ath/ath10k/snoc.c:1432:49: error: 'struct ath10k_qmi' has no member named 'msa_mem_size'
   memcpy(buf, ar_snoc->qmi->msa_va, ar_snoc->qmi->msa_mem_size);
                                                 ^~
drivers/net/wireless/ath/ath10k/snoc.c: In function 'ath10k_fw_deinit':
drivers/net/wireless/ath/ath10k/snoc.c:1593:14: error: assignment of read-only variable 'mapped_size'
  mapped_size = ar_snoc->fw.mapped_mem_size;
              ^
drivers/net/wireless/ath/ath10k/snoc.c:1599:46: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
   ath10k_err(ar, "failed to unmap firmware: %d\n",
                                             ~^
                                             %ld
       unmapped_size);
       ~~~~~~~~~~~~~                           
make[5]: *** [drivers/net/wireless/ath/ath10k/snoc.o] Error 1
make[4]: *** [drivers/net/wireless/ath/ath10k] Error 2
make[3]: *** [drivers/net/wireless/ath] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

3 patches set to Changes Requested.

11455345 [1/3] dt-bindings: ath10k: Add wifi-firmware subnode for wifi node
11455351 [2/3] ath10k: Setup the msa resources before qmi init
11455353 [3/3] ath10k: Add support for targets without trustzone

-- 
https://patchwork.kernel.org/patch/11455345/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
