Return-Path: <linux-wireless+bounces-19258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971EA3F40E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 13:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FD57AC140
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A53E20CCDB;
	Fri, 21 Feb 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rAD/TbMJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47A20C48F
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740140257; cv=none; b=X58nF6pqOs3OT7mnAFBMsk+k3gtFIU41hUxaGRgOTvK+TLVi7mwEAZIAeIN9vHd3kUxxJLZdF7e00k076PX7MEe6gZFnAPxi7enSvwCm1mNnRAcMhwQ4xMNcELDJqfetwI8zuM2x5tDy4TyuZdMZmpwUvcDkvYyzFMKhvDlJuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740140257; c=relaxed/simple;
	bh=mTBMj3E/n5IeMqQRvfQyOY/O9t430kCU/k4wmNWIp84=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=regZpA3eEQoD93iF+CnowCEj4vIQx+a3SuPwdN4qqIwJ3Y4qcV0xKJvVKdNW9pUMF7KPCr4tYnxkgD25/7tLN03u+86JNWwRxZOm5ZsL7ZCh6qS4ZYF4KuLk6RVW32AFCMbiti1qfBniWJHjO70Nw0XSbj9SgQ8qb9YhHceNP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rAD/TbMJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=sOafREA0zc0M/4pprpRNM2TztA0elUd6EKGi9buzlnA=; t=1740140256; x=1741349856; 
	b=rAD/TbMJLEgdQTpRVkZHjitiVAhIPk7wDLGPQTCT286gpb+3fGka97cJRf8Xa91xyVAUmkx3xur
	5qYdoYT1sbDEH45te21RVo2z9sFhBeh6qk08AzqhJ+qQyAbe4V07rTNrWdWKj13vya/tw0lC/lLcQ
	GgqNlVo1i6zhAFFiDEraWIOEvOvK+B/urerAMn2cX6+njDo7yG0cCUC+MQHAz/2225eXXk4GCqqJv
	KmwVKlrmqJGylD+35CqL1GOIbG0/pTl7KLD7vFrb3EljukgSbXpFsHChJdOvo5EDbark8CkVZ4K5v
	hMblMUwhtQodrlAYmTI6HrChT1zxTDkduL4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tlRyG-00000005H6y-2tFq
	for linux-wireless@vger.kernel.org;
	Fri, 21 Feb 2025 13:17:32 +0100
Message-ID: <ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
Subject: please use tree tags in patches
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Fri, 21 Feb 2025 13:17:31 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

I couldn't (yet?) figure out how to make the nipa bot stuff run
properly, so please start using

  [PATCH wireless] wifi: xyz

or

  [PATCH wireless-next] wifi: xyz

for the subject line. This way the automation can pick it up, see e.g.

https://patchwork.kernel.org/project/linux-wireless/list/?series=3D936374

I'll need to fix some username stuff etc.

I likely also need to add more trees to it - please reply with your
subject tags, trees and branches to use, e.g.

wireless: main
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/

wireless-next: main
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/

but perhaps we want to have

rtw-next: rtw-next
https://github.com/pkshih/rtw

or so? Not sure if you maintain a fixes branch there too?


Anyway, good luck to me, and please don't try to attack it ;-) I spent
all day setting it up, and haven't pulled out everything yet.

johannes

