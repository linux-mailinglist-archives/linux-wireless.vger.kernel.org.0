Return-Path: <linux-wireless+bounces-11732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294395985D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 12:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C60EB22082
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B691C870E;
	Wed, 21 Aug 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qR59sUOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDE1B1D6F
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230951; cv=none; b=P5ypH9cUEOq8UI0IgcDOs6WjP6JXCEuYGRi30S8NAlOKAyifvOikJkzZ63h/zBYOJixcJ7K43thUuAI0YurPmB3vxZlyoX1IskumWlwWTl3W5Rb6l6d1o5nn2Y96aMqgu4wjLztjyNKHrJkus8YmFk0LlXEE7AyIEHxYc9/Y6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230951; c=relaxed/simple;
	bh=qOklduUEbvp5oN8c7BoLl5LBtpj2L2tKsEPaR4+TpMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7ph2JYKngADnsMjwjnxgrvYnagROzDlAsRfvvw0N61Qq/tgPQ5AuubfWOVHlUO814aAmIunnOJ5B641FajZvcSpxBe4/odZQmeSpf2JfVGGF3FW4F3vKCQw3N4fy1Q7YhzRr9XGIl3vCShvrI8pPjK0Ll0QBQGs9bi4CYT31LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qR59sUOt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wtp3Qz5A0XgPxPDlZxR1TKHWNrl3r58lrtp5LD9lTT8=;
	t=1724230926; x=1725440526; b=qR59sUOtCvxQH3x+sXQuONaMQU8Sd9NlDO4Xik/Drx9pL5c
	WaU3OsR58QOTWRIDj7VbWHgBFleBXCyrsavp1To/Mv42zkNRjBO8znH8rT9eDAeHR2hVun/i72Q4J
	Ezl2mU2hrSJkVH7LKusIlDsvxBzaKM5TBJA+SM3xwJAcsQDmOUYgnd9wDz3YKjyTCS2lBqit89g5q
	Pl5/IRbsLgVJYQvNxwetQFG2K8VOm8uVXCqgWgfqO1VzMk7TokVX2eByKiSNv6P5KwlO7abyZVAYk
	bbm7t2tKKFMSRZUB08Lv4ZBa+QoIAMHHrRpOhRHf0/hODu+JWuUbX6NBvt/W5xhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sghDx-0000000Ad34-0Oih;
	Wed, 21 Aug 2024 11:01:49 +0200
Message-ID: <f7b60c2f8239974431227029118b269988a300c5.camel@sipsolutions.net>
Subject: Re: [PATCH RFC v4 1/2] wifi: cfg80211/mac80211: Introduce nl80211
 commands to support MLD link removal offload
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Wed, 21 Aug 2024 11:01:48 +0200
In-Reply-To: <20240807034521.2091751-2-quic_mdharane@quicinc.com>
References: <20240807034521.2091751-1-quic_mdharane@quicinc.com>
	 <20240807034521.2091751-2-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


> +/**
> + * cfg80211_update_link_reconfig_remove_update - Inform userspace about
> + *	the removal status of link which is scheduled for removal
> + * @dev: the device on which the operation is requested
> + * @link_id: Link which is undergoing removal
> + * @tbtt_count: Current tbtt_count to be updated.
> + * @tsf: Beacon's timestamp value
> + * @cmd: Inform started or completed action to userspace based on the va=
lue

Might be nicer here to wrap (some of) the many args into a struct?

I also don't see a need for a return value (and you didn't document it)

johannes


