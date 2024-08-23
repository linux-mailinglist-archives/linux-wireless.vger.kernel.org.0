Return-Path: <linux-wireless+bounces-11836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC1B95CA45
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 12:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F22D1C2119C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FAE188906;
	Fri, 23 Aug 2024 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aU1txMtV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585DD187842
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408176; cv=none; b=MlfFuxNQPax25vGi85m9i/QA7BX/Kkqgs4lr80ApaPQphFAZ1tvjyduN7KBWkhZVqRs9Q2L+pQB4UQQVXm/3bP0IcIaiGw1mZgsjptcOvDOonahYk05M5EiMtwLXfp81BLs+5Wc3bSO7X8EwePsoNq4IjKfVwE/qxv+NuD5PI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408176; c=relaxed/simple;
	bh=A6mam5R45RJcg0r1KQ+glYT3alU7Xfs/N7DYWzKCnlo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtH8eqh8vNVR1b20xlh9YnwL7GSQys9XKkJmVgRqVf2v625uSijPdMgjTDFwLdW3gpL81YfRJOrmAD+cyEeFokoyv9y7BAm0m7uH6iYEpmMCuVM5XmVGLdHvFw5o6QzINDwgNseONGOCwMeFIAgktF5A4DI5GY9WfLYLwOkJvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aU1txMtV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A6mam5R45RJcg0r1KQ+glYT3alU7Xfs/N7DYWzKCnlo=;
	t=1724408175; x=1725617775; b=aU1txMtVGamXzmjm/MqERdgRWmn7NhHExAJgdk0una++Z2A
	cHAt09N6vTDIoqXb8NYUFWN7fBgLph0fubhPzxkgg8ugaV8DpZbEsVVRNla5r4yRjGOGTm4bumjgK
	BLJtYPJTTISdmYZeYRruurl5pnjv8f76pYU2MKnNdy8nM6Z6FCi6LOAXiK0TBBHUvncOW5vjijpwl
	3inZzt6x/rJSV9eW8n69mwow7BtC33EuQFlaBq9gkF1HOfAm6E8mvaUoOSyDacNvbmTp0xazP2BqC
	LpEx125PXD3uLz2NRBuPAv7aKXcjH+wB4rcKSJ9PD9DG25xTwwknLAnI7U06dJ3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1shRL2-0000000FQPU-2tO9;
	Fri, 23 Aug 2024 12:16:12 +0200
Message-ID: <8b11fddca38ea82b48ebe93a898582e698069f14.camel@sipsolutions.net>
Subject: Re: [RFC 3/6] wifi: mac80211: notify driver about per-radio monitor
 enabled state
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Fri, 23 Aug 2024 12:16:11 +0200
In-Reply-To: <b75992cb05270eb72fc9eaac3313ac3236701657.1722885720.git-series.nbd@nbd.name>
References: 
	<cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
	 <b75992cb05270eb72fc9eaac3313ac3236701657.1722885720.git-series.nbd@nbd.name>
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

On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> This allows monitoring on one or more radios while minimizing performance
> impact on the others.

But why are you doing it this way? You could already solve this entirely
with the driver by setting WANT_MONITOR_VIF and dealing with that, I'd
think? At least after this series.

I generally don't like hw->conf, it just hasn't really matched reality
for years with all kinds of new concurrency capabilities. At the very
least you'd have to write more text here to convince me that we want to
add something to it ... :)

johannes


