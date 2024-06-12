Return-Path: <linux-wireless+bounces-8840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B80904DF1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61146B22E9C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05916C84B;
	Wed, 12 Jun 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dyC52WCs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6E152500;
	Wed, 12 Jun 2024 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180303; cv=none; b=WSKZSVV5wLomx8HaO6x0jBEc6ZPP9lnK7q6T2vOnrTgc5vEII48UqsF58cDusuAKWxBGCpUsrlu1KDCl+0zhQzcNqSJHIera5KP/e5tIZC6Ibmt2xmYUGAwa3jZzZ4f22k0EjwLqIkLkfqCm5XGJC9G4Ka9m01Pg9kVvW8xPMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180303; c=relaxed/simple;
	bh=/Ook7rkBngmqtrGjbgaIrN61G62Ik1BkmitSf6tEuuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sc7lVoYxQcQhs6Ey/ss3YoBrQG578lqcyaT7PeuGD3TBWFsL/6fEnYu4nIpkLQhN9DkQo21HDjgxdH83nD+TLbnSQ3BLVQDm8PT3w7fhOeTm8X6Qkbl2qb7YQnU+JR3IZ5pj2uAjmJpUtYnPiwv1dvewlEc8szwkosFm/zgV1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dyC52WCs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/Ook7rkBngmqtrGjbgaIrN61G62Ik1BkmitSf6tEuuM=;
	t=1718180302; x=1719389902; b=dyC52WCstwvIAcPUL/G+x3j9Cvqk4kNf2lYoXWuYAje1AIg
	IyRi4zVNDG3raH36rgi9gGfpMGhsXVBwWDJjEi4szPeM1k8+bGAtDBVRMLlkpP9uD4hbRLvOhFus+
	CQeDvwT46Osm8OrRyHMGzER8a16YsLF4tjeBwXDA4QV7Witi9B+SdFfSAxFBTqYVSJXvfiQWTNn5J
	CQcJh0QVbEMZ3rym0pKLmbo+xZ5/Fkkxl2bQ14rank7yJ2YXhZIfHqzq4+SwBFEY7B4kaAvcEaq8N
	YNOq64CY3s9sQhZ9YrOyLB9W5BX6RFTVw25scHypndwufgiGryxCbknYxrusdVVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHJBP-0000000A3AR-0g75;
	Wed, 12 Jun 2024 10:18:15 +0200
Message-ID: <b3e0a55f0680b590537133bfb02cd1bbfd61a56e.camel@sipsolutions.net>
Subject: Re: [PATCH v1 2/2] net: rfkill: Fix a logic error within
 rfkill_set_hw_state_reason()
From: Johannes Berg <johannes@sipsolutions.net>
To: Zijun Hu <quic_zijuhu@quicinc.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	emmanuel.grumbach@intel.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 12 Jun 2024 10:18:13 +0200
In-Reply-To: <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
	 <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-06-07 at 22:40 +0800, Zijun Hu wrote:
> Kernel API rfkill_set_hw_state_reason() wrongly gets previous block state
> by using its parameter @reason as reason mask.

Using reason as a mask is perfectly valid.

And checking that the bit changed also seems valid.

We might want to not schedule the worker if it's not needed, but that's
a different issue, I don't see a real bug here?

johannes


