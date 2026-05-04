Return-Path: <linux-wireless+bounces-35862-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGvCAiil+GnQxQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35862-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:54:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009E14BE1B0
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70CBF30011A9
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731C3DE423;
	Mon,  4 May 2026 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs/+Qfoc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C173DDDC7
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902867; cv=none; b=rjHXIEV9X+cAxFfAKTJVcKNgeKv9XjvhuQaKW6Rs3Pi4Ao5Zbl0/BZrXcMHHfQM9lsOsYs6XONSRsVHciR9sn+WJfRsMi9nQzUG0dEocSn6yBrjpuj0QZn2tPpyvYCHAFT+g1kD4ba6qbslS6hHJxjcybUqRShyULUEMioJPI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902867; c=relaxed/simple;
	bh=qACKovDwWl0XRpk1VBafKxa+X+VCmOUgOltqbeYqeDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQ5SAEvqFGzYRACyy0IeOq3inRhhr5uYWNglkQ0oEEgrystGtBFjOey0FDFsDID11zDVoFYj1xFSfSFf/Mg1lv9CxDmxXIh4ViDA32GVGK0futzHuc+x4MzeMMRcuIXBbmExwqhuRlWiNckvtVpWF/MJymM0n6G5VH+9pau0RVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs/+Qfoc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36505450d0dso2475199a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777902865; x=1778507665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDH/Z3ZdpxZLnUyA8N8nJBFQauhNZTO1Pv4UHEM+LGQ=;
        b=Vs/+QfocrLcmeEoq05UTx0RI/iLbP9h8cXEkXTcIwiRWu4SqlpCY0WvtPhXW8kJc7s
         OwSL+N6NGl30ko71KClqyKj3ggunhUPlWeOJXn6iCam4LguU+5scVtA/L36xTDd+R4zA
         M4bxpFug3mkiwZZ0A/uA31YIQBqjSI5zfLpnTRyupVYJoN22ls+gorFfJfNHg2oQq+BW
         datJsmGp4a7/SxEVdyap8I6fvL+GJy52MeOhgkRKIB6BbQUppvPOLb7MzKqLu9cHZcor
         +YMCEKfeB65ZlE25xRq2tkB6m/pBogJFwfFN/0O0ddcl0tsWw7uoC+kH8i7DribsU5Ns
         PGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902865; x=1778507665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDH/Z3ZdpxZLnUyA8N8nJBFQauhNZTO1Pv4UHEM+LGQ=;
        b=CSIB5omKZxJJXnP2lris+dgqvnuoCwYGLxumkGTFOt5Q1Mr68KpaDcmNgu9+lq3PAt
         HHOLQipLVihZQidkNqT4fiOGcjFbrwS2gWdDFgESZDLzPC0nAG6cDohXk7CTSCdmU0Kk
         Fa8bV1MQJRWsF9pIj7eoVTyQpxPfrLuwTgMXd8wQSjcdR+G3mt6EkdvJsR5zPofrqpX1
         vgplhJiV2RO2+g5J1uqaguJ+gLKnCeHt7HkrP8I6aZIOaTSPtFdGs354XJvvS00RXMuY
         jZjdiwQcOE+c8aQGSSofiU6NluIEosLSEQY8WaBFpt/JnWgMHdmC0fQiY+BrcFnP/iB7
         oarA==
X-Gm-Message-State: AOJu0Yy+uvAO20O1/lcwd9BBe6lTFHoiImBFKFaeRdaog8PO3jqFh1wS
	OZw7hrobqjLrgbKUU8jBMos1265EGZGBIBQP4sfDSmE8RPkwta+Gy2Y5IT884Q==
X-Gm-Gg: AeBDiesRVUiTge6ZK631zfiJ5Eh1RWbWBIawQDFvEuumUHIZmtXtfOwkVZFoJ/pOu71
	PfhU39ndNvg03gQjpjW8QIHYkSnDCQm9hAckWO9G4sPgPlEdUPa7qofbGnZx58Lms3BF6o+IExH
	hZp39L6AO2UUmyAz3XOr7+7hkN7Rwd7anG/j7OmqwYIEAtbsz9rwAsKRNphc3gxLphQ4iYkz5Qm
	LRpeJDXr0b8+D0KOaASfsahpHM79TFLPm3j7Z818MHEv7i7VLmI4oRLhenY0Uc3/LZGsxKV6ulX
	P2UxRUlAyYQ0XCok2yAI5ACfyfoUHd5dmp3IFKHXrOr9rNgjW0lCiooo1JEKDSA63mBwRfSi0zc
	fWKfZMxA44hdCGhtPlkQyWGPxWjPqb8YSsizwfHkRAR3r4NMsMvHfihAxtYC1+IhQxWvIS/di70
	GHV4mZUiIydrGPffDkcoYI03GhrYb1s+huGcna94slF97B5HTqhY0s/npy
X-Received: by 2002:a17:90a:ec86:b0:35f:bd29:75b9 with SMTP id 98e67ed59e1d1-3650cee7ca6mr9612982a91.22.1777902865182;
        Mon, 04 May 2026 06:54:25 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36528ad3154sm5798811a91.2.2026.05.04.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:54:24 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] wifi: nl80211: tighten netns handling in SET_WIPHY_NETNS and dump continuation
Date: Mon,  4 May 2026 21:54:18 +0800
Message-Id: <20260504135420.1178443-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504125753.1154601-1-maoyi.xie@ntu.edu.sg>
References: <20260504125753.1154601-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 009E14BE1B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35862-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This series addresses two related namespace handling gaps in
nl80211 that came up during a recent inquiry on the list. Both
follow the netdev convention.

Patch 1/2: NL80211_CMD_SET_WIPHY_NETNS uses GENL_UNS_ADMIN_PERM,
which only checks CAP_NET_ADMIN over the source netns. The target
netns selected via NL80211_ATTR_NETNS_FD or NL80211_ATTR_PID is
not checked. Mirror the rtnetlink convention spelled out by
rtnl_get_net_ns_capable() and require ns_capable(target_net->user_ns,
CAP_NET_ADMIN) on the resolved target netns. Reachable from an
unprivileged user namespace whenever the caller already holds a
WIPHY_FLAG_NETNS_OK wiphy in their own netns (mac80211_hwsim, or
an admin-delegated container scenario). PoC reproduces on a KASAN
VM with mac80211_hwsim and shows the call now returns -EPERM.

Patch 2/2: nl80211_prepare_wdev_dump() validates the wdev's netns
on the first dumpit invocation but not on subsequent ones, where
it looks up the wiphy by global index. If the wiphy moves netns
between dumpit invocations (via SET_WIPHY_NETNS), the dump silently
keeps copying BSS list contents from the wiphy's new netns into
the caller's netns. Add a net_eq() check on the continuation path
so the dump terminates cleanly. This is mostly a clarity-and-convention
fix. Combined with 1/2 it also closes the path by which an
unprivileged-userns caller could trigger the race themselves.

Changes since v1:
  Patch 2/2: trimmed the comment per Johannes's review. The
    comment now describes the invariant being protected (wiphy
    may move between dumpit invocations) rather than referencing
    other dump callers as motivation.
  Patch 1/2: unchanged.

Maoyi Xie (2):
  wifi: nl80211: require CAP_NET_ADMIN over the target netns in
    SET_WIPHY_NETNS
  wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump()
    continuation

 net/wireless/nl80211.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)


base-commit: 65493f27a6008bf84bd11bd41c5e1ea6b0bf3c3d
-- 
2.34.1


