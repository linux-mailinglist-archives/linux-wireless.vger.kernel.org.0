Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60333407D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 15:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhCJOkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 09:40:20 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:30746 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhCJOkF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 09:40:05 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id D76A47B672;
        Wed, 10 Mar 2021 14:40:01 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DwZVT5HJvz3Nk2;
        Wed, 10 Mar 2021 14:40:01 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 93070218C;
        Wed, 10 Mar 2021 14:40:01 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 707B78D4A15C;
        Wed, 10 Mar 2021 14:40:00 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id EF9C2E707B5;
        Wed, 10 Mar 2021 14:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id uQx1LjZIoXIQ; Wed, 10 Mar 2021 14:39:58 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id B88AAE707DF;
        Wed, 10 Mar 2021 14:39:58 +0000 (UTC)
Date:   Wed, 10 Mar 2021 14:39:58 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH v2 iwlwifi-next] iwlwifi: do not use __unused as variable
 name
Message-ID: <alpine.BSF.2.00.2103101439520.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On various systems __unused is a define to __attribute__((__unused__))
and yields compile errors as a result. Use __spare instead to describe
that these bits are "unused".

Sponsored by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
changes since v1 - reduce diff context
---
  drivers/net/wireless/intel/iwlwifi/iwl-fh.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index aaa3b65be4e6..e6fd4941a4cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -580,7 +580,7 @@ struct iwl_rb_status {
  	__le16 closed_fr_num;
  	__le16 finished_rb_num;
  	__le16 finished_fr_nam;
-	__le32 __unused;
+	__le32 __spare;
  } __packed;


