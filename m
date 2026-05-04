Return-Path: <linux-wireless+bounces-35838-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GN3NgOY+GknwwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35838-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:58:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F894BD503
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 372AB30241A1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2413D522F;
	Mon,  4 May 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5v7MpAY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013903D412E
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899480; cv=none; b=crISWDPsLYmxd1Hi7Jgm5P6eGsSAP5v6tu7ZfDYyhYeST4glMOYLzV+SF4dFMPAX31/P9PRZWOVoR8CCe/JkVNMTH9SLQfzZzRRy7wM8+TnGSiDg1DVU37yeKMhW+m5+whaU7GFz6h84TyXJreDZlKM1RGorEJZhlomVdBniR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899480; c=relaxed/simple;
	bh=8C+jTH4+6gg49HnleBkJQdFA7p6j7XAXUBqpnYWeUgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpK0HnVHRoCQcrYdg8ymmYTab2mslpCruxIcYYncmisGGf8Pi1NrePIqDInHGXkc2apVgXbexkSABqkFirkjK7zsGTJIKXpG73gdh+FVEw/nr5UtatMiRbYCCrSIxmAF+O4vO1KH2kUEibkYiOSwsKNb65OdR42itzdRyYMeiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5v7MpAY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82d0b68837aso2055592b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777899478; x=1778504278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ziP40c7w2/s/DiY0dugh4MNR3tJwQtD/Glp3x6P66k=;
        b=f5v7MpAYFGSzYt3K4j/d1j5vUim8Re7di4Cz6gnvwtqvRIf4+EwfyTpWg2vH4GEi1t
         sb+pN/1XOV9rubCR1iSML/F9GCn13h7HsCAn/CR3N4o0ODOOo0QEjKr20fhglvYtm5px
         ARq7HRjKCz97CLY2tsLtgzxewBJwQoVskhDJATD8eE1SZdeZMSmYc0jLB51FkT5veNcO
         Vz33QfXVD2offfzRicO5vjR4tFdfxkRObBKLOVUA7sfMtys5dseMQBoFnBXRKngEjGPi
         yAnseLIfQ+j73ILTN7TN92ounsUqPDk0XnWpKQ1hq5imxlHturMjXEUmXZiA7SKLmvSe
         /u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777899478; x=1778504278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ziP40c7w2/s/DiY0dugh4MNR3tJwQtD/Glp3x6P66k=;
        b=igCx1K5f7TGq4TwF/iCJH+PR0EDJVq0PS1afku+eWhbGcP4/cAP7RAN9nkMm068NiK
         O/ZkL5AFBLfx+EzpmaJNjptyFFo5WFFiEIm0GNWvZrTbQhSpiFhRBm5M+2xz05hf0OMu
         1YN3ahWtSz4ggXDGAfKYwXFIhMkIVNpMQ/YjXc9jvSPKIhpnGq1Lpj2rb6hx263GF99M
         mjIcFRpzCwz/joL9Zce/GDoGuVUaNBmm00PqjsHQCa+7lWyWPTEEpBMInCQNZtQ5hyO+
         Z/OLzYOVlgm1k64ONr2fMHT8nyiseuzGSwHAHUIv6/cIFPD8NfJxDb6pAlawXKypKfec
         O06g==
X-Gm-Message-State: AOJu0YwZlqmpu4GIqmPMLJdd3gGx60wVRUOZOKIy43TEadoXLVtbV5EK
	olaeYSXiw0XPQmotgwbvD8f2Fo/WV10O0+pHrcaS+hCE92956w6HR7uY
X-Gm-Gg: AeBDieuBGOHrJZtwd8q/zCnpfKF0v+CERjLD8HxOWsEy2o3w6E1rutYXVaKdp+idy7c
	GKlAcTaurr16bnLCiywRnBt6x7FgxgBAm8G+X33WEdUEfdJRwlTROjHqhqi27HmURPnjhybd0GL
	/Voljb2+Tdl6v0ioRboL6FueQZ8PSKlA6Pwdjyi/S3GCkRSKokScvqSSxUmTXKUDVKWPeXgjdpt
	DDVs6+TYOZD4foEK4eCONmYqMwn+5siQHJ/wx/D6/+AOYrIGBbzuv7+Bc+VfKcuyA0Dv65vN7gx
	wE6rPtl0gZNQLWOJCZaJwPi9iq52VOwEksmzf9++mM01m3wDx+fLOCCX/ErtIdLHQ0DtAR6Prdk
	gK65xGY2HkrYpkPUuNiNSwFu2IPw9hWdshq9wEKPXZn9xNKRUoWQ7oUg+cL0fuZc4By5N1G3row
	ucddT6q5+tgYdprWWTQkEtQdFFif/bC2txX+KzmjGmteos6leaWmHzkpqi
X-Received: by 2002:a05:6a00:428b:b0:838:2058:7c30 with SMTP id d2e1a72fcca58-83820588200mr2176788b3a.36.1777899478039;
        Mon, 04 May 2026 05:57:58 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158aeebesm10748864b3a.21.2026.05.04.05.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:57:57 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] wifi: nl80211: tighten netns handling in SET_WIPHY_NETNS and dump continuation
Date: Mon,  4 May 2026 20:57:51 +0800
Message-Id: <20260504125753.1154601-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 85F894BD503
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35838-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
the caller's netns. The other dump paths in nl80211.c
(nl80211_dump_wiphy() and the scheduled scan dump) already
re-check on every iteration. Add the same filter to the
continuation path. This is mostly a clarity-and-convention fix.
Combined with 1/2 it also closes the path by which an
unprivileged-userns caller could trigger the race themselves.

Maoyi Xie (2):
  wifi: nl80211: require CAP_NET_ADMIN over the target netns in
    SET_WIPHY_NETNS
  wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump()
    continuation

 net/wireless/nl80211.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)


base-commit: 65493f27a6008bf84bd11bd41c5e1ea6b0bf3c3d
-- 
2.34.1


