Return-Path: <linux-wireless+bounces-29301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D98C83196
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44FA74E7F72
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 02:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570311E7C12;
	Tue, 25 Nov 2025 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="42fIHAo0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA21CEADB;
	Tue, 25 Nov 2025 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764037717; cv=none; b=oLNoLOHirIidYTSyoUmWER99y9O8aKJlWNKk7S+Ovli/zIg6cTiziliuyG9CjYK5jcvOsAq2GL3TCQCHWGr/dFDsrHWF/nQX77nCxmdjNxJj/CaSZax8birXB/aekGa5jChb0UafaUMAlLpz6c2yFld78fL4e0ZJY+qAZaoj06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764037717; c=relaxed/simple;
	bh=YCYC8JHFaYllYI+ljh4vw+JFM86KvGj1+HAXw2ZzTRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzK/45VB+NYozFLcmdkru6T6LtvDK6mo9QuVl9/ua5bFw8HXNWxsvQBUEGItaXdNLhYKfoB35CGj0kHuR/PdHpfXBukwWGzMq7Bnjw4nbORFo7lZ/xFkz1dRGeCyj2liHTB2efx8vSXEi9/zTkPhaFlkazfxELm0fE7j5jbmeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=42fIHAo0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+0Q4hphoJOzk++G8gec0+4d6j9mGaOuQzNXh+obzMPg=; b=42fIHAo0M2OLd29Ta19vutHim2
	lO/bvuO1+HAZqF2m1nJ0Oa63wVzHNtg4CK7piPXC/lJB7SD9mbMXFAGXnXuEi0zsTiYrz1CRszY+B
	unkqARTh1tIvJyLfDShH5z3ec6FZNr5//tzUpv0NAVTqfC4EhGB7gVWO34LpmHazTerZmPJBxbJLt
	GTJ5SSV6/HcMvtzxwi45+Z8JqFccJTcpD/olZK0NRmaMzYpHxIOBk0zNYgL9HV9n7RIxIlhNfNP2i
	4dBl5ZTJ4WmCbscmx5EkZe2tRA6SGBywJTWF8R0+PBRb2SWIrMG2weePyrakhwFQgkqYARb0rgMF5
	lZ4nkcJA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNinD-0000000CcQh-0XTg;
	Tue, 25 Nov 2025 02:28:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ayala Beker <ayala.beker@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] nl80211: vendor-cmd: intel: fix a blank kernel-doc line warning
Date: Mon, 24 Nov 2025 18:28:34 -0800
Message-ID: <20251125022834.3171742-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete an empty line prevent a kernel-doc warning:

Warning: ../include/uapi/linux/nl80211-vnd-intel.h:86 bad line:

Fixes: 3d2a2544eae9 ("nl80211: vendor-cmd: add Intel vendor commands for iwlmei usage")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Ayala Beker <ayala.beker@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
---
 include/uapi/linux/nl80211-vnd-intel.h |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20251124.orig/include/uapi/linux/nl80211-vnd-intel.h
+++ linux-next-20251124/include/uapi/linux/nl80211-vnd-intel.h
@@ -84,7 +84,6 @@ enum iwl_vendor_auth_akm_mode {
  *
  * @NUM_IWL_MVM_VENDOR_ATTR: number of vendor attributes
  * @MAX_IWL_MVM_VENDOR_ATTR: highest vendor attribute number
-
  */
 enum iwl_mvm_vendor_attr {
 	__IWL_MVM_VENDOR_ATTR_INVALID				= 0x00,

