Return-Path: <linux-wireless+bounces-21927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98B2A993E9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790883B7416
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16E28CF45;
	Wed, 23 Apr 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m83KXzO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CE27FD74
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422637; cv=none; b=bPOILmeH7t2E/FuERrCaxucTatzk7wVmq3BKSMg7qGGI03BxB2pbqkM1xBX/lKhRzMb6Sp28rEJa8IbXqtxSQtdaeYLgU77B4Phu2aBQIiOxHNid8wgyvofaBeyk2Ajyfu0LfyRnX7acgVlqKc7Z+VBJSDsc2qvxZYPFJpUVlqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422637; c=relaxed/simple;
	bh=BLSZPwFCEqmKmCaxfFWRipZdPiY0TPEJs4bHk6F8cFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8MiuYV7Qr9OtTEHgcqK5psyiIcBSmvx0xN4Ksw4zt7VzBLMsnSdtEUtSamfBUgtiT5eYIhVZIoLiIaZ6CpX4S3ukQ9IOLmdw1ceaqgWeE1L+rbT7PMej7wCcjIETqqItbVJYl3DLC88dAufrVuJBLnDYqY/PeyO4a/C3A6byV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m83KXzO9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6XLPMSzz1Vz+htlDUKAWrnwtgcKaUXMjf1vKRrNcp44=;
	t=1745422636; x=1746632236; b=m83KXzO9BQMmmOPGG3W5Nx7/eCvZRfubHHltRf2lKUnZsMv
	Ka1P/yL3+DddPqIthCIUG7uHsUEIRnVoobCjYqlfgSK6iTrIlR+6nvklGusplCb4lsICS47nm/b4Y
	IRM4TE6B9Mh+vCni8BT6iM9ozGlS8fxphuElEqQqigG0w6Mv0EsAt4aX9btxeEHqtKyfxXVo2YPR6
	9lossKwyVNg58BwzQfL7Zic3HwjdumDDy4w3DRW5fCujFZaeJujh5+NcSmudw9LIA4rH/oYKKWMl5
	lsnsgBwVdbgOwzIClRRcCdQ18NUCri9bLRWRfd5jSedlkEFabVZPlMYUtC/rp9Xg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7c9v-0000000EnXX-1BV2;
	Wed, 23 Apr 2025 17:37:11 +0200
Message-ID: <c9f5231349d941505f6d479463f31b5a76f3d65d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 2/5] wifi: cfg80211: Report per-radio
 RTS threshold to userspace
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 23 Apr 2025 17:37:10 +0200
In-Reply-To: <20250328122519.1946729-3-quic_rdevanat@quicinc.com>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
	 <20250328122519.1946729-3-quic_rdevanat@quicinc.com>
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

On Fri, 2025-03-28 at 17:55 +0530, Roopni Devanathan wrote:
>=20
> @@ -3237,7 +3243,8 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, =
struct netlink_callback *cb)
>  						 skb,
>  						 NETLINK_CB(cb->skb).portid,
>  						 cb->nlh->nlmsg_seq,
> -						 NLM_F_MULTI, state);
> +						 NLM_F_MULTI,
> +						 state);
>=20

Please don't make unrelated (and unnecessary) changes.

johannes

