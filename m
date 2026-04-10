Return-Path: <linux-wireless+bounces-34643-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KluOqlt2WmmpggAu9opvQ
	(envelope-from <linux-wireless+bounces-34643-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 23:37:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5346A3DCFA5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 23:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1714A30103A5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CB63A9D84;
	Fri, 10 Apr 2026 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj2LWJw9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5501DDC33
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856772; cv=none; b=HC4s/a9u+3ZoGLQy9Z0DTWrwHKBaecuBg5qG10xsUhMw9EsIcHJsnCDLkUBWSZ30wjnWq3C2bAceTA51TRhnDxZI/NX82FXX5rsnNFOUAEo0nv42vlltscfHyrKqcaQ0RwHqHcogMsmmk2GOvJiTEjW40C38nTAshLxJp645gVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856772; c=relaxed/simple;
	bh=nLhjlJiU3+/+LomwAM9a82FpFYGsLCJStbkTwftBYm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvK4WbYg1nC67l11JAIV1u6bA9zL3UMg14HribreGa7h9z7uAPRuPy+GkW6ETNrYls6AoTErN3jYRTpdq0etx6tG6IZ7+NkOQQSCCsYhGX8H2arp0tb+YyJt4VyplEj38pxeA/xXJM5T6LgespVh1vrV2LL3LdjkKRyp7nyYrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj2LWJw9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b150559bso19323825e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775856769; x=1776461569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hH0M544Vvi0UzAcBHXAje9ywo7OlxtUhp4t/ixlJK0g=;
        b=dj2LWJw9+L6gxh6qeXJ9qeqGPbSxcPYxYEBhc2u9Kw74TB3F9r8/yGQTe5LBvllGmo
         FWjiOG7pv+ql4cUgP2e9mGRVRUHj36ucYmRloN7SpcGw9NlFJwfPJiUKCgctwSUy+cpI
         aBb7cYKPvgqMoTDqvqsOlXoZ67HbEc/K6TY+UTKvjpaP6CjXkS3R2ryTpR0c7PzsAN2H
         SOidU7TsU4JiHq3tIEUccrdxC5FJmPnMWbW40u5bPqArzYVumsOXf7rH7G/WBoPIiWIa
         OIZ88hgtOvkP19ttL3UJL56H4r3N4pIltnsTNXvEenlG29cEg7IF/ADb9lETg0kQ9Xzl
         oQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775856769; x=1776461569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hH0M544Vvi0UzAcBHXAje9ywo7OlxtUhp4t/ixlJK0g=;
        b=DtFaYeeOhrsHcXJBbeGw5D89233rluG/0f5ZqBqaeK9zwQcGGvCAA4WrPAurwt29yi
         kkaO+jMnlBM7ysjf921Gzn1KbvDQSKYmQ/BZMwxJJcI4SF/jOsGPIOhpZL+SPCx9eTOQ
         1sgytX95ORYQhMSGVQxljUhPwtoccTUgirTKT3OjKCQBvfZ9140fQtpdR4KDET+g47k1
         uAVY0sZMpUKUqDRMCAyqY8n19aiELc07YW6wtP8FnawoWbumysGyKR5yZ/A1KFwRtfeb
         vbKFNDvtEgJNZ+2N05p8jjs4+GT7E/LSc0MUcUxkRaiJ/Y0VDX0rvlwj2bojlfchnNgF
         SPjQ==
X-Gm-Message-State: AOJu0YzZyvx0iy7dP+LrIJxSWqdGZMnHYynq8EOy1NMBx4NBXBX4DpKa
	gQLosKfDGSi9Xt2/4DV9HSJIWfPIBSJ+O6DcWRH3+1wsBhNtSVE98VG/DVuFXol9AQ==
X-Gm-Gg: AeBDieupDGNSA7LcsZo3n70ZwtTIpK/6Rv+7iwDz+srSXsOrq+tn4BPbMZy9wsp//FI
	dnKe1OvOh84G3RvXwVkepb/l0anTWjd/w4bb0NM2vWyJ5z6kyMviwtjx6tmbQBV30/AiIwaz4Vc
	NamKUVCOcQ5J5uWSavrHQyYnbxcqnvrzzGbeHPFZqYUp1Iu5Xoi1D6ERo0QnI00DpI3qf90TRER
	ecw9iaHMqVWM2yfGSnfK1993asOIZsTRiXzYrzXR1ivImLLOHA8Je/jJmpc3rgccUEajD05CEK5
	3S1X5hKJy7wwYOajCGbin4Y8u9WWLJubc87gzy9eg0J7TYe0nK0VUbpJKavhWVNlvku82Zws3CX
	dmGBJajSiYcnaJgfZ4+kNTWKYqUAb/LTmJNAK5trKXXxphctEv1A5n3BzEfMtybDSsSDAvQ6wYD
	N6wN8mWtkt3hNCdmAv24gm0kM/oMLKJJ0qgfY91Z//YRuD/D8e0Tu5Ts3PRJmdJSZGORJvSMFZB
	5LmPTk3Rf2r8DE0HeRpxR0590G5hFM0n1IqphVlYmqdAdbIC9P+Gw==
X-Received: by 2002:a05:600c:64cd:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-488d67df57dmr64188905e9.5.1775856769394;
        Fri, 10 Apr 2026 14:32:49 -0700 (PDT)
Received: from archtop.localdomain (92-242-249-17.broadband.mtnet.hr. [92.242.249.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec28asm10753094f8f.15.2026.04.10.14.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:32:49 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Szymon Wilczek <swilczek.lx@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Dan Williams <dcbw@redhat.com>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Jakov Novak <jakovnovak30@gmail.com>
Subject: [PATCH 0/1] usb: fix bug in marvell libertas driver
Date: Fri, 10 Apr 2026 23:32:40 +0200
Message-ID: <20260410213241.1177592-1-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,tuxdriver.com,redhat.com,lists.infradead.org,vger.kernel.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-34643-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5346A3DCFA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch fixes a bug inside the Marvell Libertas driver.
The problem was the if_usb_disconnect function not properly
calling wake_up(), which lead to if_usb_prog_firmware being
stuck on initialization. This caused the lbs_wait_for_firmware_load
to be stuck as well and to trigger the error message.
The solution was to add the wake_up() call inside if_usb_disconnect.

Jakov Novak (1):
  add wake_up call inside if_usb_disconnect

 drivers/net/wireless/marvell/libertas/if_usb.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.53.0


