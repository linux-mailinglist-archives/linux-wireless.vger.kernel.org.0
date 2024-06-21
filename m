Return-Path: <linux-wireless+bounces-9430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F4912556
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 14:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F641C20BBF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941E14E2CC;
	Fri, 21 Jun 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m5vtIMih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8714E2E9
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973099; cv=none; b=VLqX2qHYYL3whZUIZA5qfIeRVK72P9k0FtoEeQahkUzzcMjFe9VynaYwFcT9/7UuliKWIjCh7JN9FilFUsLWKcw6P569Isk6uv+gj7hx/oLkaisUhO2dPUooruOHy5PrjJIuwl25JDvsSZLhIp0ROtkkuLc1uKHK5xOZUzdHTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973099; c=relaxed/simple;
	bh=3IvlQV8u0jdU76uxdcdxV4KO5CbsJ/wgywiK1JVP3DE=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Fdc3pTo0YqkHX3qSQdKOGtUl+wg+KbS6Tar8IW7bRy3CRyYyuTCyC1tLaNcM9P81NbD0IiARQJRq/Znm3Alr+m7WjuMJXHZyGzDwv5DoY3airm1JAVT9J+kBBcyJcHxJJs770mRWKLU5KG0Lpoy0YwL7T6cm511rEJT5uRQb7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m5vtIMih; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=kJg6/3DUDx0BMuU5bmlpHH0Z2Q58nBwvHsY4PsbkRpo=; t=1718973097; x=1720182697; 
	b=m5vtIMihvlo4wY0f1RAaUVR7SklQ3bPW3xLUL5Pyn6MIqG4oFqmvbyr+k+0yDmVW/QcAHhI4MGb
	ciCQPb3aPG0Ati0KNujJUgewgCxsIAcBnn8nWercV42G/5TdkkNw3YrjgH9teMNQItJHU/3MasLR0
	Q2COa/8FVsYQmL+n9BBNciBorphT+XfWbtM0Zc6D+WjAW9TBwPnUnDBaXyudnbFgP/ipxPQuB6jl4
	d0/ub0lfZi+9uElnLPenz65DXKbZ9pIkxiU3SUubigDZlu7AOumSftPhv9hXNpx6dm3oJkKJTG+hS
	YGbs+GDjNkHQLBzarAYOS0jTsojIFJLuNkLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sKdQO-0000000Bsn3-1ZY3
	for linux-wireless@vger.kernel.org;
	Fri, 21 Jun 2024 14:31:28 +0200
Message-ID: <b7ca414c297df4acb0a8132339293ea7249cfad3.camel@sipsolutions.net>
Subject: Receive OMI support in mac80211?
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Fri, 21 Jun 2024 14:31:27 +0200
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

Hey all,

We're contemplating adding some support for using (sending) OMI to save
power or perhaps other reasons.

The implementation logic would seem to end up being somewhat similar to
some other cases of changing parameters (CSA or simply AP doing
HT/VHT/HE/EHT operation changes, VHT operating mode notification action
frame), but=20

 - for widening bandwidth/increasing NSS:
    - update chanctx
    - send OMI / wait / response
    - update TX configuration for the STA it was sent to

 - for reducing bandwidth/NSS:
    - update TX configuration for the STA it was sent to
    - send OMI / wait / response
    - update chanctx

FWIW, one thing I'm still unsure about is how OMI interacts with VHT
operating mode notification, but we don't transmit the latter right now.


Initially I thought it might be best to have some kind of request_omi()
function the driver can call, but since sending the OM field is done
with any data frame, I'm not sure how to really get that done - a new
driver op seems a bit overkill?


So perhaps it'd be better to have at least two new functions that always
have to be called in pairs, like prepare_omi() and finalize_omi() and
it'd be up to the driver to make sure the field was sent inbetween?

I'm tending towards the latter, any thoughts?

johannes

