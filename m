Return-Path: <linux-wireless+bounces-36859-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM++M7PyE2puHwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36859-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:56:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D715C6CF7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A44F30015BE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 06:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B33A7F40;
	Mon, 25 May 2026 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxscjd6x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A73A7F7C
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692206; cv=none; b=rWAgdQoqS8sDDWUX4Ne88VlYzBFPVBTPwkkk+v/lX6gL+B99Sdg1kEXzl2GYvNPE5XyOU1hfjikWMQqtzQL8h7NlqOgmTxBY6+tRhbaVWTAKEd4U5KoEoG9oRY+LJg6s+j6LiXT/bQkmhOZVzthjNkJhYPHv91eUgnsgJf0idLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692206; c=relaxed/simple;
	bh=jDVOMYhYewn6ATtZbKp3VJy/YN+xTXplywg9VZlCfOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JyQEein+fOYYccOcKueOBC+2aQxFLtsP6P6sKt9MYbk/3R7cbJiBjjA90mKLXIJUnWW9cMfMFctcRZe8NqD+sc6yiT/gcREfhP90cAhKqHvvFjI8qANjl0GyJbU8wxKd4rgS6YoZFQYqNo5dT8zmDWz+aiEJZKLJJztXkpsBoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gxscjd6x; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44e1860558fso5868302f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779692200; x=1780297000; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GW1L+sX0aQAPGDZcLmvDCGiKclqdN5QY1XJTp1+tXFo=;
        b=Gxscjd6x0aoKCADdgTqMaBa/5VQ/n4Ru5Ap84EhCmT6zDhO79/Pecodw3cfEpvvJlH
         8Bb/fCyxbJYuRaZbIZzhLdxNQbvwR0YLy0DdXrgUwSzMP5jo1Vl8dd5NsVUolf73usi8
         oKXW9PUBFyb+kt4/zlVQ/RLFR3Ie7pCN1sSzK0WTPeufj7+GQEPW+UWXp4cikoUIFw9N
         Q8O7giN6AKQISk0k/B1AZXxDWMbTtmqTVCDz+Zh0MhnqlNmvBiZUkQD9wG4s1nlwuE1j
         Eb+ChdSCebUTVSujtZ98K2mQhTnjYg4sjxPOg/3pqpq2NCRuLrx6fDPAZYFSdwt6Rs4U
         uIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779692200; x=1780297000;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW1L+sX0aQAPGDZcLmvDCGiKclqdN5QY1XJTp1+tXFo=;
        b=l2lbxG9evKQqaPyB9Wd66bV8rzO/XkJkf21g9AJY1XmfIb5dkHw1ZAz4icKuqf7OUA
         HVXFQ5j2foiKrd+23BlDL3Z2AFPuK2a7CRfTq2O7u8ZUejv0qGDZHOYMBhVewGGUtEf0
         t1IaNafy+J/0x+1lg+p2xSJbv4iFF7IzpmpSdHieWJ5eMgJR9mnmnkJ9wqclctzl8NOh
         ppWB7I2M8P2BcBNVHV1XsqQxTBJC6hPNeK2ieGqU8g1FO3+2sYxFO2UkpB+k4BQg3fY7
         p2/Bt40QWaxwboZcrVmUZDuP7yPAIepGhYkessLsyZWMkrGr7BIsCvxyTm3pLX9sDYpr
         p62A==
X-Forwarded-Encrypted: i=1; AFNElJ/07RckpI/XMKEhaDQRZfsWFvD96HeXsevpl45GNOPB6z8Ow2pcnizCKUjn4+dH+5glA6B6pDRTfV5XMj0hHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRYR1qbL4FZN8xTh3ec9GTO5O+lRzAMY61G5CA9tr9SIz8W7aV
	IOBEoBnDZ1meCiZdxJjSlfTj6ugtN/sV5eUpUSXkxJl34ywWCV2JOB/D
X-Gm-Gg: Acq92OE9YsgdYysCTfL34q5zmBO/jN2XM83eXCR8OzOxt4EuMyJ1Yo3BYzYReP6x+aM
	Qv5qJxxwqPti2I50jFBD8j8c5faZYaRL3T8/DLGAdb7eZEghtZeX2fTRTTLWXBAOz4Q0t/F9Zvl
	MLBa20AugPHbeXgdhRwPwxXg6dV2bT/hLS3H083J+jqC/6IMJxUufY5iWT2p4mtwZ5tkfV8OEzq
	BeJVu6sLqEDY/gog5RnSz7sw/FESjgKpSq6Wwi7puI+SlPKr2WrsKRMelZfjqDRdunQ8bcO6YGx
	dcdlhVyHohXf51/k9EdQzA/ABu8X5Gi3jGTDdmkLv+3/7K/qARtFgzzUv/C6lIlQTafiDpBSJXX
	8VtsjXhx6Zup8apVwNl3Bptr+f+oRBwxEBjWHhKY1A7byFqp2aGPAuGGpVtOTaSM0V6AMMkFhPW
	LTbCz/1RrQky1TSvEN7M5MnifiiHjBSAMr8Q==
X-Received: by 2002:a5d:588d:0:b0:455:7c9f:a49e with SMTP id ffacd0b85a97d-45eb38c5508mr24586775f8f.25.1779692200400;
        Sun, 24 May 2026 23:56:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5c32esm23804272f8f.26.2026.05.24.23.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 23:56:39 -0700 (PDT)
Date: Mon, 25 May 2026 09:56:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>,
	Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: remove an unnecessary check
Message-ID: <ahPypOdz-KXh5KAJ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-36859-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D6D715C6CF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We know that "start_raw" is true so remove this check and pull the code
in an tab.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 .../net/wireless/marvell/mwifiex/sta_cmd.c    | 35 ++++++++-----------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 70ce31d7c76e..623ddde8c8e5 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1568,28 +1568,23 @@ int mwifiex_send_rgpower_table(struct mwifiex_private *priv, const u8 *data,
 			return -EINVAL;
 		}
 
-		if (start_raw) {
-			while ((*pos != '\r' && *pos != '\n') &&
-			       (token = strsep((char **)&pos, " "))) {
-				if (ptr - hostcmd->cmd >=
-				    MWIFIEX_SIZE_OF_CMD_BUFFER) {
-					mwifiex_dbg(
-						adapter, ERROR,
-						"%s: hostcmd is larger than %d, aborting\n",
-						__func__, MWIFIEX_SIZE_OF_CMD_BUFFER);
-					return -ENOMEM;
-				}
+		while ((*pos != '\r' && *pos != '\n') &&
+		       (token = strsep((char **)&pos, " "))) {
+			if (ptr - hostcmd->cmd >= MWIFIEX_SIZE_OF_CMD_BUFFER) {
+				mwifiex_dbg(adapter, ERROR,
+					"%s: hostcmd is larger than %d, aborting\n",
+					__func__, MWIFIEX_SIZE_OF_CMD_BUFFER);
+				return -ENOMEM;
+			}
 
-				ret = kstrtou8(token, 16, ptr);
-				if (ret < 0) {
-					mwifiex_dbg(
-						adapter, ERROR,
-						"%s: failed to parse hostcmd %d token: %s\n",
-						__func__, ret, token);
-					return ret;
-				}
-				ptr++;
+			ret = kstrtou8(token, 16, ptr);
+			if (ret < 0) {
+				mwifiex_dbg(adapter, ERROR,
+					"%s: failed to parse hostcmd %d token: %s\n",
+					__func__, ret, token);
+				return ret;
 			}
+			ptr++;
 		}
 	}
 
-- 
2.53.0


