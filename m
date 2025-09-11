Return-Path: <linux-wireless+bounces-27242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604DDB5350F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 16:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18744AA287F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F720FA9C;
	Thu, 11 Sep 2025 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dh8+Q+v2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39C20409A
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600375; cv=none; b=iR/g3ENHpUzdHkL8nyK8ZBRn/YENiMrvYoiUJmfsCBbqzotWqXqGprTF6M2Tg2iiVuig95gNo/791IJDBeuPHQeyVAn5aMQ6/GMxFAmRk835o1lduWRIi+MXO7qMVSSZXowUeZanp4fYKJwHNEBR+bTUVg6gKdWQNX6hJqZb2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600375; c=relaxed/simple;
	bh=b43YbRW6IkLcbeKei1BIp9QhWcENc4Ev6AVbapM97Uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WsbjaokvdQvcOvqHuaOjdv9ZpZ7koecpG+88v3mU9qLzlvTMzeEsncacb6Hey0n3VO4tCu4lFpTWOy1NXKPShy97n9oAIqz8242Nr8eOVLtpYcHmmnw98Tvnx1D7ER3s0UDmGRM2AozcaeNb2Z/oJJlBj8fl8d6tWqzwefaNDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dh8+Q+v2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b43YbRW6IkLcbeKei1BIp9QhWcENc4Ev6AVbapM97Uc=;
	t=1757600374; x=1758809974; b=dh8+Q+v26kv/VS18h7uW6S1HfGsIQDuG1e5RWwfJ+ep/3kM
	OC+gbw/5K6UihQLTtWTw3B3eh90I3/rPS/rN1mNlqdaF7GuZzkl21urn+Fp4SwyO5YQnHcgdBS8Ms
	2dZnplmKlGEl/3D+w73fxpEt7fO1oEvdtHsJ03CSOV9vEH95kU28PjwVwV1q1vSdF/ZXTwN1mpbej
	OGnGU9ftaGZxQc20HjDBEhUvWU/k00wGxTSAE1YV1zIJO+g6eAd3abdTUNe1L4smug4d/muad8YDb
	U80PIi/mNt5chTxuSbxLaJvByfFeYs83+6HFN92T6XaXRjASkFbNEKzREwKYA1Rg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwi95-0000000FQcT-49es;
	Thu, 11 Sep 2025 16:19:32 +0200
Message-ID: <b77ccbd69c69a797ba1f7bccbaec5837f96b8bb2.camel@sipsolutions.net>
Subject: Re: [PATCH v2] iwlegacy: Add sanity check for il->stations[] array
 index
From: Johannes Berg <johannes@sipsolutions.net>
To: Chen Yufeng <chenyufeng@iie.ac.cn>, stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org
Date: Thu, 11 Sep 2025 16:19:31 +0200
In-Reply-To: <20250911133950.1152-1-chenyufeng@iie.ac.cn>
References: <20250911133950.1152-1-chenyufeng@iie.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-09-11 at 21:39 +0800, Chen Yufeng wrote:
>=20
> Reviewed-by: Stanislaw Gruszka <stf_xl@wp.pl>

I don't know why now suddenly people have been adding Reviewed-by tags
for *others* ... do NOT do that!!

You are of course allowed/expected to add tags that were offered to you
by others in email, but I see no email from Stanislaw doing so.

johannes

