Return-Path: <linux-wireless+bounces-35255-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAzpN3Gj6mlF1gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35255-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 00:55:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBFB458456
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 00:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26FED300A13C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31433A6F9;
	Thu, 23 Apr 2026 22:54:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E1342524;
	Thu, 23 Apr 2026 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984898; cv=none; b=E4h5Qfx4QAVmPNkMV5sRYr5X6ERRuDK2y+69im4hdLCAuHgyzBCw8/5OLmSzI6W//U261/naliOhRZl3nBNlkI0TDLeDlNY5RfzvABLCv6+mcY3LrI/npp75CdYJApDdT6zrrMWoYzrF/TUGG9kbOgzVi31mw//rS+iQ2P+bsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984898; c=relaxed/simple;
	bh=oo9+ecjWT/Z1mknOQ/2xHkiBtde6zMXiPXDFU83Hr3s=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8aEX2JIyClr164aWGI1DHqEMM5yVxjJ92nAttSi92YuPTFeJjWFFQ9lWR2Q/ymTMgb7QiEaaR2mHBOHMgUhxKeu3tlQ018n41rCp7ySB/0sZtvzBnNPIDHMVddQSKc0TC+D7q9grN8hiB8oS+an9OT8B2GIp1bCfReC+BrDtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 12-mac80211-minstrel-drop.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowABX5wo+o+ppqpVsDg--.56179S2;
	Fri, 24 Apr 2026 06:54:54 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 24 Apr 2026 06:54:53 +0800
Message-ID: <20260424070112.1-mac80211-minstrel-drop-pengpeng@iscas.ac.cn>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] mac80211: minstrel_ht: bound debugfs stats output construction
In-Reply-To: <20260417075642.32502-1-pengpeng@iscas.ac.cn>
References: <20260417075642.32502-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX5wo+o+ppqpVsDg--.56179S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5E7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z2
	80aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU0pBTUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35255-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BBFB458456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johannes,

Thanks for reviewing it.

I rechecked the current minstrel group/rate bounds and agree that the
overflow claim does not hold statically. I'll drop this patch.

Thanks,
Pengpeng



