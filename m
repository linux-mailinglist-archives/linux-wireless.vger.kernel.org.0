Return-Path: <linux-wireless+bounces-31521-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGPHF7scg2l/hwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31521-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 11:17:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD51E45FB
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 11:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E6763025900
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973F3D3D1C;
	Wed,  4 Feb 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/IqWxko"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0538B9B5
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200156; cv=pass; b=IN0KXsjNiEJmZSZM+SddTE1L9emHy/tyKLUleVcXI0JQO2BtZbnDXDKT807qYCvKlMf0QNzAILRkeN1PhPzGtEeiVRUfjX51tuEJTNkYs/gE+CAZV2Zw2AVvy4ACt2SaCuBscIH5A3rc6rS7lM62NSrHQAU15ukCqVegwEOTg6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200156; c=relaxed/simple;
	bh=U2SZUJ4vwKEV8AGXg/Pcz7quXw/+sB9ZkQglPIRsmo8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GyWG9d0Cj3OQarMlsJJjjg1ypl1S4s6E1u4/WcXliaj2gI80L3WaK0SBHp766cTB1E7BEhg/Q3mAJyPWbtfK/3SNe5EbTSDoyPkldmyuQeXkm/2ViuP18neC/qkbTJiQqm4OxL2SW9624fs0oKLxyKSOloEXQQdeYQEvRg4McSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/IqWxko; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-89473f15ed8so59867056d6.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 02:15:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770200155; cv=none;
        d=google.com; s=arc-20240605;
        b=OD0l51DuAtV9KhZKkcXe71DWGq2I9IZ9Cu83ICTGRdM4E7T/JvNotFZ2Ms93kU6rhb
         77OVG7Zx0DG+tbF84wGBGL7UqRBpn3a9zsumqjYuc7CUA4hyWzh2hEbs+2UBll5caqag
         gmzNl1tpdx3NaBIoL6UdpR0aeFGxr0P/K/MPIp//vX90Y5jMLVobzAVn9npwPgNJAxtE
         uHmZ3Ht35KOply6orvJSJRZacUp5JJOGLMV6rVNa1AgVcRz+lMbF0psLyYrF1cOPT7gV
         5wrJxaXwsah7b0vtTt4Wlj0issy6iLDf+dccPU476yovYF9giSu/OP+0nFr2PK0Zoq2w
         3N/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=U2SZUJ4vwKEV8AGXg/Pcz7quXw/+sB9ZkQglPIRsmo8=;
        fh=7Yzgn1l3rVOd6Hjny1/fBPSfQpme1BL+qT6Z2RlTWO4=;
        b=JgBZdQcys5dN52KHyI29O14yxbS6WemLDAM4a3H8Tq/Hg5X0Pybb5XwG3DB5R3C5+g
         B+GRKI07XRrn1BHAxmXEGsbrBrmuZ6/WCMaa4Gro1KcIY0Z4qgQT5mgBX5apAoggC5PK
         iMWstPERcv7PuD8DaZpYWaF+YYQ+X/+bNXYmnBO+6vdGyTz+64loVUGDjE+oJZJ6f8Ml
         ceRjLk0iRlHvFvTG4XwGrlCpm4L3/STgbjYtTcJwxNXfFnWn+ovWG6X0fXedq2CdL8Fk
         Pr/iYesGvmwmgEUjO8UWDPpl7qN4BgVA1eURR3isqoDsEl8MyV4Y59/qat6fETT0wnHO
         a2KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200155; x=1770804955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U2SZUJ4vwKEV8AGXg/Pcz7quXw/+sB9ZkQglPIRsmo8=;
        b=c/IqWxkoTmZTqchniIeBJw01/j4HCZ29S4PHSoPNYvNI67jYmEOZNlCjtZvpqKzwGk
         6g0RzCK3C+U+/iWCkXnOaDfplG21lUOV0gtJPVWg7gAF2m98Jg4wkndKs3buscbrJu7X
         zIUwTzLlIf95ET3NSXGULTLeE8thcCQoLxb4VXNEI/ghuHPAFAIL68hv8DEwJXAXNdDn
         iXsxcG2FjdYgr779waTclKcZ508uQSVzzpMNzBzTwIaK7Pw+kTNw4/roDksU+TO9tqo4
         d5wxlnLl3oby+DSy54ixfr/RxCmADaU0kMWSoJIb7G88e0UsmDIzIFgT9rgCll9aBGjL
         Kmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200155; x=1770804955;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2SZUJ4vwKEV8AGXg/Pcz7quXw/+sB9ZkQglPIRsmo8=;
        b=pqNCyF9OeTJvO2WMqpS3TuQFovCtvm9CBo9oaPwXCG3+CU2NGMmcqZMI+Jr5tngmcQ
         2XZ8+UCpVgBuUYxjPlVZaqjUOxC4xJYxRE9Gsw3icjW/3FQh+m1C7sTfaIXbS3lkx0gx
         jmC4r1Ilhrjq/kZ1jWjtvIbAUrUXHICy9G7a6y6DTm7OOq+RW8meNGYZDBuSgD1Ah6jx
         CXTxpIQLCg05/TstW0/FG7f0fPld4l3DDu7qUvVcysm/hzZIBdruHkk+XlqbGcBEB68F
         jGAPV+aXk26O651HYDPHM07fqaA9iVDjlXRnZQJCpzVwg//MKoS88oPwzCJmBUJvGXVW
         8Ssw==
X-Forwarded-Encrypted: i=1; AJvYcCVmBE8BDNIdhXauTW7jgX8gFnensWDfnUNl3RXfTetq8q+tyVbU6ONwrnThMWlN7LvKv8KxuTD8XjSpxEdyCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8ZFzAnrO277JFpnXh+F+piZ0B31vC6Vx90ohwuRKz5bfaZQc
	ZWyYHVk/KNiRHR4vwNUgfZgLHWu8nM9BzWatrWoxGGNdqz7SJyCPriTnwI1NX232gIli9sgpg5f
	Cm82PpS4xIcAvdnXdkQUmH7FvcAqIFUE=
X-Gm-Gg: AZuq6aLpU2pVExHcratZadEn3lB3ILYTIOMA94+cCcQmTr6AYmSUnyw8suUY+gC94KK
	qQk0JJxc3a7rZmriaa4T5u/4RvLCcUY+q+r64jD2UoQpDSZQ4K2qwLVJ7SF88JGt8lcvRGgDIsX
	izT1yCkLTCeNRRx3nAEJhN31WdVuq9QQlt8eFqJZWkTiKNm4hBBVB++d5hdD0I6krwLdmgUMZ7M
	h+2cYdC5h6MnZdYIJ1HEoVEMEfelFET0FGvRyAcBpMrPLP3mmb+aK9XPQjFgNehtnHRlshWF6VW
	w2WLzkprKs91c/++FQ6PYtshMSb6RIM450w6r1o3vYvXhlDwnPk317VJ
X-Received: by 2002:a05:6214:410d:b0:894:5f6e:fde3 with SMTP id
 6a1803df08f44-89522101930mr33818186d6.19.1770200155305; Wed, 04 Feb 2026
 02:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 4 Feb 2026 02:15:44 -0800
X-Gm-Features: AZwV_Qhu3PjSdqm3E8rcFb457xyh_rZqtpf1XguM6GwwOWxTIMYwBBEqTi_NSxY
Message-ID: <CADkSEUhXO-01yaNUawo58MQ=xOC5bCDHWCFrCwe6TX2D+WVR=w@mail.gmail.com>
Subject: PCI ID conflict between ipw2x00 and i40e
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31521-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AD51E45FB
X-Rspamd-Action: no action

I have written a script to find device IDs that are claimed by
multiple drivers in the kernel. It has found that the PCI ID 8086:104f
is supported by both drivers/net/wireless/intel/ipw2x00 and
drivers/net/ethernet/intel/i40e. I assume the i40e one is correct,
since that's what the ID is assigned to in the pci.ids database. Can
anyone at Intel confirm this?

Ethan

