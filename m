Return-Path: <linux-wireless+bounces-38708-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AiQhMXf9S2rleAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38708-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 21:09:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 381DE714D22
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 21:09:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=SxrzTXw5;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38708-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38708-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B99C303E9C5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058133AE712;
	Mon,  6 Jul 2026 19:06:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9C3BCD3E
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 19:06:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364787; cv=none; b=IV7do8URRDa5Kx3iOorGLlxY0a6NGzG5krSIU5wby/H7/O3AXmdU1y7kGysl+P9ddt39v9f9MAOxbj3TCUyZr8Ds9GZjTyC+JBpd6SeBZ4h8NE6Wr1pbNZNANvgVNU3hj1k/3DzLdp2aD7p0TFjOJ97dF6zjNERgeX0inS8X6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364787; c=relaxed/simple;
	bh=xw/k+sI/dhcgLap5T+RapTanFb/HoTDYJ0dmwehQwuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No+bKSW4Ty6J6p60K32yg2W4RgZsrNKPkYprBViATuk2QaadsAlXQt2Hgv+S87b1kCewXygFZcV3yYIZa8DJyjYcN+HBDRH/Zl0ioPRDv9aIy4bRs0eD6PRZXbF/uRC5OAYbIpQ8JDsmmIQc1vGCSb2hk11xMEYk010cidhwCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SxrzTXw5; arc=none smtp.client-ip=209.85.222.99
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-96730906293so2276235241.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 12:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783364784; x=1783969584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCcqUcOAsizeBq9mZ3srg1wuiUpRLdUbtEdjrL780Fw=;
        b=FVU09XAzXgCjJxwzyWlhGZfa2ZZ+Sa17PFjyzR4tK8jNx0XJuL8KN70cJGG8yOZ9F2
         28iU0CyNRz/QH4/IAPm0gV0y7Azi/7NS2evf3ab2a9udwCX3L5RZSFxJfUWFWnsSAW8s
         SKGps1ZMkV8O8oxVJ25RHSJkVX+xgwFIl/UD8Ys8EzbVL5k/f9lbaG32L/i6lyMxTof5
         A3HuE5F8QchVAX9/1YvkQe+kSLmdmYB1akHTmjEk9zWR8RSfb0C6k2oX+K2C9TAA+Jkk
         dTbEvyELrH8fJuI6AfwDihKhHKJO4t62ceGGvS2V1QHI8jRW4C5ju2Rt9QcJWPTiouH6
         9sYQ==
X-Gm-Message-State: AOJu0YyNDX32HZtxfQRoFeYDCyu+Yr0CbbmQlxOs7LlG/B23KvEQLHu3
	XAhzfWw4RwUaZppziE3WS0quUOTsYkWd049LOWPIarJBlpBo/ehym1e3Vv4B/HrbJPM4Ooctern
	dYl1mliL3C49Da5vqTH+G7/toVoTNDsWdxaqrX6eL31DT4gWyDyG4HJIQ41YPzgnEcshWBlDTvH
	JPvPbriQmKyYevSyzpLNlsKc8XOPlikGVwUSHrLpKK/E52q+lBQ1oQB3/z9kdvdVRCyy4ootwRB
	0djeSrSoHwGvsXnfonYyTYO/2VX
X-Gm-Gg: AfdE7cmLvthdYU2v3Kfd1GmETSoD903NnQSNSOc3QukZ1nSDsAqIun2oME5W/EJ9aPy
	9QOlUX7+ZyoGi4uEcNj3MsgzLFUZhN6RRhcIvZ+QQhRb6urmNPT749V3Q++7ls6yAAKssmBLh24
	UXti6/3ReVZ68DHqhWMjwGZhOUGD472FKEqfv004UNaRRvBXiYKi1ZMt1GcAspXhfk1t3O/SP1d
	1pn9u5uLG/1Ftrj5Qt0f1SBsrAQpK85WCjeO0UoiJE2svSDwArZbiUn6mdzHMBgkEV963sbkmqA
	hsAPAw8Rd4XLXXzyhEu6H2bYpozWIU0L8Ec7FPQuIiasPlZ9S6WfQ3TwnafukwezHbcLZkfIRoG
	UzSTt/4SDp80mUs85sxC9m590i3IO0uu9bCJHIrTN+dTihlYvdxH+TMmVNNeESMjA8MNIwwSLqq
	ZOKKYu5Y303wyg5NdrM9+XV9CmHLpgayzI9MRcGrmJssaz4DU9n++9
X-Received: by 2002:a05:6102:8025:b0:728:aa5f:dc5f with SMTP id ada2fe7eead31-744b7d56b66mr931041137.25.1783364783817;
        Mon, 06 Jul 2026 12:06:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-73e19f37b6asm1067538137.12.2026.07.06.12.06.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 12:06:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e538afe65so335642785a.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783364782; x=1783969582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCcqUcOAsizeBq9mZ3srg1wuiUpRLdUbtEdjrL780Fw=;
        b=SxrzTXw5uqa/qpOpAAjNMM5BH6R9EOIm5YLYFKI9hpoB3CN7A/nG0K2ZJovV4P2vAU
         DXPNq3HjPZWkP3hZgpreBjbBN/jza+4+O0bIbfGNVVMbNRm3UbkKoMxECSI1wvkgmszA
         bBq08FEKqd5xTQ/tbw52yAbdUrJD5Y+whj5FA=
X-Received: by 2002:a05:620a:6013:b0:92b:5ec7:e619 with SMTP id af79cd13be357-92ebb599704mr252260285a.52.1783364782040;
        Mon, 06 Jul 2026 12:06:22 -0700 (PDT)
X-Received: by 2002:a05:620a:6013:b0:92b:5ec7:e619 with SMTP id af79cd13be357-92ebb599704mr252254985a.52.1783364781565;
        Mon, 06 Jul 2026 12:06:21 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm964890985a.4.2026.07.06.12.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:06:20 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Bogdan Nicolae <bogdan.nicolae@acm.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] brcmfmac-cyw: clean up PMKID and cookie code
Date: Mon,  6 Jul 2026 21:06:12 +0200
Message-ID: <20260706190612.708609-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CA+ORkNQPL_qdLOSC2Ae0Y7-wihKVRaaO-DUajN-3rpjzyoEtjg@mail.gmail.com>
References: <CA+ORkNQPL_qdLOSC2Ae0Y7-wihKVRaaO-DUajN-3rpjzyoEtjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bogdan.nicolae@acm.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:dkim,broadcom.com:mid,acm.org:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38708-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 381DE714D22

On Fri, 3 Jul 2026 17:39:51 -0500, Bogdan Nicolae wrote:
> Avoid setting packet_id to cookie, which is always 0. Instead, use an
> increasing atomic counter. Avoids mismatches of completion events later
> in brcmf_notify_mgmt_tx_status, where packet_id != vif->mgmt_tx_id is
> checked.
>
> Also, zero out auth_status on initialization. Otherwise, garbage will
> leak from the stack to the firmware (when bssid is less than 32 bytes
> and/or when params->pmkid is set). Then, pass the params->pmkid to the
> firmware (without it, the firmware caches a garbage PMKID on successful
> authentication and denies a subsequent association request that includes
> the PMKID).
>
> Signed-off-by: Bogdan Nicolae <bogdan.nicolae@acm.org>

The patch failed to apply because it had line-wrapped diff lines. Please
resend. git format-patch and git send-email are your friend (well, can be).

Also, the subject line is missing the "wifi:" prefix. It should read:

  wifi: brcmfmac: cyw: clean up PMKID and cookie code

Regards,
Arend

