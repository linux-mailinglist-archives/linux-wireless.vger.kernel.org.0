Return-Path: <linux-wireless+bounces-12459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB1C96B30E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C595C1F20EF8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0EB1465A0;
	Wed,  4 Sep 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tE1YzAPa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE84AEF5
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435652; cv=none; b=eDFRGH1vfHw4e0rT6McIO2ex/VNu1EK/20AHYH4u+7NNbC1eOEekpUedxxi/Crqc4p+i4SdgQLaK4ljc5wBqU8pGv+l9DfmhtawmgvbSxFOOHGG94/Vlfekrp3y2Vqv5JZo2VyWf3cIS2D83Ot30EDpmD3Jh1y83wHL5R56kdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435652; c=relaxed/simple;
	bh=i/oo5r+dd7j/SVZ0d5Yf6oNgdOH2FlqcUdUeco08E4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECCSv7gfbeNNBbX187cbce5lGKb9ht1WgdI4VTfXx2Cc25SfrDdBGTsbgpKe5i3zwuATsORE5zrpWN1BRg5b//Ztf2E5PHynUcW8TTxxtmF1xEAiZR1xgq3FbsWtL6aKXdtK4EIdGSt8ClMdWjma46iff1jv8CXlMmZCDa6Jw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tE1YzAPa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i/oo5r+dd7j/SVZ0d5Yf6oNgdOH2FlqcUdUeco08E4Q=;
	t=1725435651; x=1726645251; b=tE1YzAPai+bTV5tuZl0ddqm16//noLVifkjS/ueNoHFwRD7
	xebmYu7cK+IP28mYuzKTWvHI8knTlbUXAUWIwfJDyq+ceJC6YFDh2h+tUTferMQc+vVrH5xgS2tu3
	T0rCVx9bJNFohBYl80C1gKFCXZ3IvAolR/4Z7orXagCh0vHpOVIQBsMExac9hVSmkazDhRd8njS/5
	9PFl1sUzUKeJx7D7ke9BSRb3Cd5ehJs+jqj3llKwhnIJfBDUMGWDMuqkbC41vlbdN6EEYidN8Losz
	9tqVNkz296rnHtnux15fbk2XQj9GalPAlS4UDw9plGNFKYahJThLJm/gKVFNIoBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slkdD-00000004Px0-2yGb;
	Wed, 04 Sep 2024 09:40:47 +0200
Message-ID: <037a8342a820c9be41ba367280df4f448e741c05.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Avoid RCU debug splat in
 __cfg80211_bss_update error paths
From: Johannes Berg <johannes@sipsolutions.net>
To: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 04 Sep 2024 09:40:45 +0200
In-Reply-To: <20240904015520.3571295-1-quic_vjakkam@quicinc.com>
References: <20240904015520.3571295-1-quic_vjakkam@quicinc.com>
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

On Wed, 2024-09-04 at 07:25 +0530, Veerendranath Jakkam wrote:
> Add rcu_read_lock() and rcu_read_unlock() to avoid suspicious
> rcu_dereference_check warnings in __cfg80211_bss_update error paths.

I don't think that's right. Every other path here just uses
rcu_access_pointer(), and we own the 'tmp' at this point, so that seems
correct.

johannes

