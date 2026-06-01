Return-Path: <linux-wireless+bounces-37254-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFZqM79vHWp/awkAu9opvQ
	(envelope-from <linux-wireless+bounces-37254-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 13:40:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B3D61E789
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F41B306DABC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0A35E1A6;
	Mon,  1 Jun 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NxZq/K5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F12E7394
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313602; cv=pass; b=WT1aWBqLE5y1XJ2wepdUuUCM4CN0iNVHDnn2saOvLqhusxoY2e/n/y3vyY5PXVF4ynHJ6qBCXJIbnX7NhuDF0++yh6vKioR7YHXa9uQ3LkBvnPWew6qNZzwKdXcx7gkOeJf6xUQkmLcDxQd4m+0BIS1pkAdOwwUxKhkjO1Y9ytU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313602; c=relaxed/simple;
	bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dCmogWgQ3LvQ/pmR82lWTWHwWdc2FbikibjFVedUVYOMya6Uu28ZW4wxKjbgBAeXlucEjCHsqNbdFz5/wY3zaWxr3rrAkYxYCrSt0Nxx82hMvZEdo6n7aCmak2DnyDsHhx6U8a+x1/UuElNIMyzjKqmMGUcE+XGAyLCT87qPR0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NxZq/K5P; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c859a374903so391262a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 04:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780313600; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7cIb7Dollcj/cJSE8eiDL/FpWioRTj8txNbBVybDul346Nh3KaqbvkwhFncrcS7Yv
         N7PAAm2sVf8KMldqiJhvsGE/yZWQfhoOxmbPIQBeossg7IW9JUSfreULU9Oj3NUEkYaO
         1VY2MCq7cZC6awV9rNacL2f+QMgkRCWm53X+RwgScoL1SqaH3e5l0ilfh9kbHdgJq5JE
         vb1nggdcYwBdNiap+zUD9wLgUqlEWMiAwECgkcUzMtq3ljfAtxcBU6cSKcgwO5RLQVBL
         H6OYbQw1snH3/lCaYEg/m1ibiH3EVKZo3H7BsbkRONt6MBfqaNmEN3utJr5c0LCPuDVm
         RG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        fh=zhYuQIUUIStYocHDrFQfxj3woRZBd+9CwLJ9JB3R06I=;
        b=aKRBauznhJ1QhsJv8XN7F2v84We9TE/oNX8qNiaf0M0BfjwZHRmHuZ/Fuylucame1l
         Qct2InihWPvH747rm+vb4Nz0muNVt/7nRmiu+UasNFuJ3rw79JvAVI4bmaL1M4jCG5K2
         Ce6YqtcsghhYCRj7bBYSre55yfc74BUDmmv9NFui6b9H46oX9xqSuolXyUiF2lvf2Ch/
         bvS7khdEQzhHufZLY0XZOCEdvrnWw4vWHHeKcKVqtc97hspCABG9VCPw/gJ6PjGANDAT
         0EXVnsAMPTcHM6IH3FpgudzjSt1+bf3cjdrydFJkhpYc/NoyjLzJFjG9YkeXj7lIaqMY
         s+9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780313600; x=1780918400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        b=NxZq/K5PUE0h0E5mGzSrCcr06uEotsZJnn5qP20NrM5IJBFexugyZDJon0nmo7VDjK
         LAsOk5Kav4Jj2LBD7XkQV9KBDwQ0DJjBWBd2u5tdFg443tQC8c/v4YGU0fSgAeinMXtP
         UILenMZXPIcO414OeOhdT3GDiKYB3rE/cdROQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313600; x=1780918400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        b=l8uC9gsjOTfpMxnhIoyIoNQTnQtdz5SKFWBxGQQO1mliVpvwHTKwfacM63QezJT3KJ
         UVnlkylSkZg2ST2WTODHlr/Gba/7T7QUM9ABYIXx2AOip/zvCEF6WVv9HK6Knykle3Uu
         RSYQ+VY7PP3czDVCtaYU4B3hSOEcmvmDasrOX4rxy+97nHWLOPPgBxvA922tBSJIX/4T
         NS6v6eNeKaxMx6G5D9wc6defEWIsDcjHGnsuOYj0ryYrl4iG/Nc7EPm7UeuEVFnnvSnb
         aA8Rtwp/IqPpe2/moragEZE82vxTrNyAMlZ9R3YZZfhMnJzTYwC5FLAUfzImQmnopbKI
         gWYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/aNu69dlOYHw3B6KolAFbIyAkePbm9qfVlfkCffblFZP4gy6mBme8NEK1bxQy1S8Z5H7WXng3xp/jS9jIS3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS02glZeNJ+Ox7FRpPUz9Y04T3I+qb7aomFNC9/cHogKmuzW9n
	phNcaPXY3BqN8mcnKKnrKndDjxvCeMFS6QerfY13PteqvFo3+r59W+IAK2WNOn5c8bLIm74uX44
	LY4Te82uwv7/Q1jzER4SJ7aE9rnUmGzZs3kn2n+3S
X-Gm-Gg: Acq92OHzbLTGIqINhZtH6BbwWPIWA4BjWvp6WbE5ToPizEizY8LlL3lbkkM/O4KjIr9
	dF6liu45vSp4LdIc0OdtSog8AdtT2betQem2AyY5ZCAp/Wu4g0a68cDJag4C7rm9HDy6/BPQTy8
	E7MHWeqDCGzMv/Q+R1EeEcj5HfIgBWtGlDTVca7AvkGxieY7dX3XuOV6n3SDrQ0A/wVWgvBMpvp
	LUxYYJW+SK+YY+iNQxfiayc2AmzwTO4yenLBkOmiGmD1BMZ19gxraFYcbZ/rARJM4CZN2jbtBz9
	cKO0+kZZ8hKY6JLLjSD6tezsBQ==
X-Received: by 2002:a05:6a21:7a96:b0:398:b433:87ed with SMTP id
 adf61e73a8af0-3b427f5dee5mr11677802637.44.1780313600132; Mon, 01 Jun 2026
 04:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 1 Jun 2026 07:33:09 -0400
X-Gm-Features: AVHnY4I4Oq7kfzkvATZfqv_I4dIxsQYBxFxWE5rf6WImcq-_O15EbAx7JO-P5HE
Message-ID: <CAM0EoMkbu0Y-qhtdQ03Zn93JKOUHd6yZy-DJ2mtYDC6aehsR6g@mail.gmail.com>
Subject: Call for participation: New Age Tooling BoF
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: netfilter-devel@vger.kernel.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, netfilter@vger.kernel.org, 
	lartc@vger.kernel.org, ovs-dev@openvswitch.org, bpf <bpf@vger.kernel.org>, 
	people <people@netdevconf.info>, PJ Waskiewicz <pjwaskiewicz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37254-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,openvswitch.org,netdevconf.info,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:dkim]
X-Rspamd-Queue-Id: 35B3D61E789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apologies for the shotgun - I wasnt sure how to best reach out given
the short notice.

The recent AI tool bug onslaught (on the victim side for me) has
highlighted the changing landscape on development tooling.
As an initial skeptic I have to say the quality and accuracy of the AI
analysis makes me feel like i have been in some deep slumber. I am
still very clueless.
And for these selfish reasons, I am helping organize a BoF at
netdevconf 0x1A (week of July 13 in Rome.it) to discuss this new age
of tooling.
This BoF is a catch all for folks engaging AI in security (you will be
in a friendly environment!), building tools, doing code reviews,
generating patches and general automation. The intended focus is
networking, but adjacent areas are also welcome.

Come and discuss your tricks of the trade. The contribution can be in
the form of a talk, tutorial or demo.

cheers,
jamal

