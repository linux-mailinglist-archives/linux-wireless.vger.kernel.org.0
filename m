Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8543265EA
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBZQzP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 11:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZQzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 11:55:09 -0500
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E10C061756
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 08:54:27 -0800 (PST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id E5AC8760F3;
        Fri, 26 Feb 2021 16:53:45 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DnG2K5lfgz4YSS;
        Fri, 26 Feb 2021 16:53:45 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id A307626B8;
        Fri, 26 Feb 2021 16:53:45 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 653858D4A15C;
        Fri, 26 Feb 2021 16:53:44 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id D4A37E707FF;
        Fri, 26 Feb 2021 16:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id ZIJJ33TV5g1N; Fri, 26 Feb 2021 16:53:42 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 3361EE707FE;
        Fri, 26 Feb 2021 16:53:42 +0000 (UTC)
Date:   Fri, 26 Feb 2021 16:53:41 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH iwlwifi-next] iwlwifi: do not use __unused as variable name
Message-ID: <alpine.BSF.2.00.2102261653290.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On various systems __unused is a define to __attribute__((__unused__))
and yields compile errors as a result. Use __spare instead to describe
that these bits are "unused".

Sponsored-by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
  drivers/net/wireless/intel/iwlwifi/iwl-fh.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index aaa3b65be4e6..e6fd4941a4cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -568,29 +568,29 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
  /**
   * struct iwl_rb_status - reserve buffer status
   * 	host memory mapped FH registers
   * @closed_rb_num [0:11] - Indicates the index of the RB which was closed
   * @closed_fr_num [0:11] - Indicates the index of the RX Frame which was closed
   * @finished_rb_num [0:11] - Indicates the index of the current RB
   * 	in which the last frame was written to
   * @finished_fr_num [0:11] - Indicates the index of the RX Frame
   * 	which was transferred
   */
  struct iwl_rb_status {
  	__le16 closed_rb_num;
  	__le16 closed_fr_num;
  	__le16 finished_rb_num;
  	__le16 finished_fr_nam;
-	__le32 __unused;
+	__le32 __spare;
  } __packed;


  #define TFD_QUEUE_SIZE_MAX      (256)
  #define TFD_QUEUE_SIZE_MAX_GEN3 (65536)
  /* cb size is the exponent - 3 */
  #define TFD_QUEUE_CB_SIZE(x)	(ilog2(x) - 3)
  #define TFD_QUEUE_SIZE_BC_DUP	(64)
  #define TFD_QUEUE_BC_SIZE	(TFD_QUEUE_SIZE_MAX + TFD_QUEUE_SIZE_BC_DUP)
  #define TFD_QUEUE_BC_SIZE_GEN3	1024
  #define IWL_TX_DMA_MASK        DMA_BIT_MASK(36)
  #define IWL_NUM_OF_TBS		20
  #define IWL_TFH_NUM_TBS		25
