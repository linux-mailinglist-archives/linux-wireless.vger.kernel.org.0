Return-Path: <linux-wireless+bounces-20154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EE7A5BDAB
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7A67AABA9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41223099C;
	Tue, 11 Mar 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jDOSRYTb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0532309BD
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688438; cv=none; b=kj+ifBBFChBJFK1gsokeLmVXc/KXLa107UFVx+dgU9/2Inu4c65EBjvDJqMzbrlwU3y382PMvT4nXzV0qSIyXlnV1RL/dF89MuI0MPt+XOtEzrYDESjtgcuHpOlzcMtJQnkm08plyEt+Ybt+gmkNMn4yyw69+W7F9NsUO/1vLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688438; c=relaxed/simple;
	bh=E58YAOFbZbMjhh+VQgySnFj1q52p/+q/6DfUF4IItAM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=I1Ed6NogzoJl7u0cKDl65Kma3RnBeoBh2AK5qUJSrKZl50sRAej1OEFSoIBDz2cH821lrOpUaAgvfOSVuWOWKqlIHXOTN1l4EQ8Gj91T3DqiLKArFgEQWvaOO31TIxZbmGsaLgiPFoFjCCYyiiMQNUl5914nfyJZjnRPEMES09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jDOSRYTb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Date:MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Cc:To:From:Subject:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aDEcPICgPdcj4BLkvrHUhCEXWz6wWt7eYDl1f2//4jE=;
	t=1741688436; x=1742898036; b=jDOSRYTbKy01eOuaE0OsRIsW5qIRcvYPR51/QjEMaoc0LCh
	nSsT+xNorKoA6fMOhWC0++4roVeigjIXZrlHG3UUG54qTqfUWNdF9DuRoS65FpnMumZaxAmOrLit0
	JENTpBko35uX/do68QuZPwaw/Y0ocs418+iOrm7RbwZXEeyrvCX4ioCloj+us9kk9eQlkBT0dd/xM
	iHm666D/9iIQyDb2QmIl9ftqmfNsZ62fXsnyjlWTi73LkK66D/STEEFsAV7IOSHdNWvMXZRewuZav
	gXjjkmcGTNPs0fmzUWmZk+1byV/ykKKF7XqSlQWOaoFv9cX/CUPNksVLU3DFiABA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trwit-00000007nFL-3oTm;
	Tue, 11 Mar 2025 11:20:32 +0100
Message-ID: <9a2d609041f3797c48080ca8a2a63b56be94c358.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 3/4] wifi: mac80211: Add helpers to
 fetch EMLSR delay and timeout values
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20250306062157.1185769-4-quic_ramess@quicinc.com>
References: <20250306062157.1185769-1-quic_ramess@quicinc.com>
	 <20250306062157.1185769-4-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Mar 2025 10:46:30 +0100
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-malware-bazaar: not-scanned

On Thu, 2025-03-06 at 11:51 +0530, Rameshkumar Sundaram wrote:
> Add helpers to get EMLSR transition delay, padding delay and transition
> timeout values from EML capabilities field of Multi-link Element.
>=20
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> ---
>  include/linux/ieee80211.h | 74 +++++++++++++++++++++++++++++++++++++++
>=20
That's not really mac80211, but not sure what we usually do here.

johannes

