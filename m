Return-Path: <linux-wireless+bounces-7671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A548C61D9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F71B283C79
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A59481D3;
	Wed, 15 May 2024 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n6nQGJ2m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17147F62
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758748; cv=none; b=Z+fL1u5sLb10F6xwwKR3VbEmRCL0eeZOgGeIVJyDcuFBapu26dBMmlocGYGbpVvFFHOlqb5UcQ8/ThoBWa6/aCR6dvxENfWoZVgtHOIr5u2vn9DUCZRpS73a+H2Mkx3WQgQ30OxuRe8GFZzODLW17ZgIg4NAYC79sG3vGvEotkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758748; c=relaxed/simple;
	bh=lVelFii0CbnoAC30bDzZ9oTmwKctKgWD6iZNvfgxSzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpChFXidbX0jYLIsxaADDDjdr8rqTpOiKcUU6TXi92Vktoy7Df+2g5jYVpWN+qAvvfWYCO1oTO17bcAdVd6cB3v/qrO02wpfXDyErbP9ZT67in85MugvZ4H8UyToRPze03uMiu0iVKyLqdNYkhWZ7DKKRFt0FPLWP0BHjMxWG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n6nQGJ2m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DD8P2XfHmTiujvLCv6GbjfvN4BXTM+yVYAgEPVrj0WE=;
	t=1715758746; x=1716968346; b=n6nQGJ2mad4L21c+zIIMG1rPcEp5ZJoFEWXm6/FZvi8unz8
	uihlUu1bPJAiUmb7sItw7A0Wek86DNjfc6xux1iD+nD+HkPjpRekIhgwVYqaawdJEEKbfYmz3OEPI
	d5dyziQmf8n0PvUASiO7HDQbSUyKbPeTU3/kQOS0pMDEjMsFvhYyuaGndS+H4zLPslpki60mJxwYH
	EpHJ6AjxygLxw/ofjfISD8dI+GmEj2quooxxPyycDYSwsYDIMnmXUIWYUdt1r0KfQ8+jjj1Tlsw/D
	4W6s+KqhL/ZInwDEkIA9hZskB42ADcxBwDryj1aamnFOvSJxQS++X8tIvxFF/0Xg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s79E7-000000063rL-3TPd;
	Wed, 15 May 2024 09:39:04 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/6] wifi: regulatory: remove extra documentation
Date: Wed, 15 May 2024 09:38:35 +0200
Message-ID: <20240515093852.ebcc9673558b.Ie0b58c1249c6375c60859fa6474d7cdd8862b065@changeid>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515073852.11273-8-johannes@sipsolutions.net>
References: <20240515073852.11273-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The struct member country_ie_checksum doesn't exist, so
don't document it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/regulatory.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index ebf9e028d1ef..a103f4c8cf75 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -71,8 +71,6 @@ enum environment_cap {
  *	CRDA and can be used by other regulatory requests. When a
  *	the last request is not yet processed we must yield until it
  *	is processed before processing any new requests.
- * @country_ie_checksum: checksum of the last processed and accepted
- *	country IE
  * @country_ie_env: lets us know if the AP is telling us we are outdoor,
  *	indoor, or if it doesn't matter
  * @list: used to insert into the reg_requests_list linked list
-- 
2.45.0


