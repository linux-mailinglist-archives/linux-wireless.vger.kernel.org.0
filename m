Return-Path: <linux-wireless+bounces-14263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAAB9A65FE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E86B2A79D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624491F6695;
	Mon, 21 Oct 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wc3wT3bh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF21E47C1
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507703; cv=none; b=K0zC7q+MDXTbvEy4Af1ggleOQ27mJskxQhPsvCAoPENFDLZZ3+IqoHV9MH+kfx9JT/hFRZLKQbx6feIvf+QeBdyQygC8W8wA+GgkxHLFM5zxWgbrh3J/44St0mJBxA6qkvBAixoV2jmyWuvT9QpoF6UqslXF0+mRDdj8Rc0ppjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507703; c=relaxed/simple;
	bh=o2XMLewC849W5X+QzbjAATE8lAiX+UqKnqrpAPTDfXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aQ+RaFx5cyB5CsStdMsE+i2AY0XzgKVKqACZFVihwTBq0PUq6juWZ+h57NKuAF2ZFsdwxhFS3QBNMewARbya3KAyaxb8zoDXhaMJZK4Vs12njxqGNf1FAWsSa3kcWBkusYudGDuB4RZVSXBHprM9vXQUww1u/BBr9S9CVj0/Mtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wc3wT3bh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=swCZR6O2oP08iPOJ8mThYZWgSphz7GGjrnqDWW4Lgek=;
	t=1729507701; x=1730717301; b=wc3wT3bhbpwTee20ZIRiR6/mkHtAPD7fjhFQ/5OAuDBdyzq
	hLfCVq4Lzr4CgEQy3NpqpjynBs10oJ4ttKk5FqJTMmWeBv16+bsnaDMxsU/8H9ZNzOUeqYeGwTIIC
	hj8c3+/zJ1M1H3qzYblLBAyv6Sn++jqjarwPzC8gP+bVi7nsPm4gkYIxSSaIAeL1Vw3uoGMeG6NqD
	/3a63O1Ew/SinK5OKIHZQ3qU9k3OkYwEf6HvIsTo/szJQZ9XkoCBnqZrIVRWHxp0o+kroSN01imew
	FQ/vGQoZSpPo3dpjUejLdktK5+GyOk/L1W9EzJU3FunDL/ngDUuKtWQv08AymTLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2pxR-00000000ksN-0cce;
	Mon, 21 Oct 2024 12:48:17 +0200
Message-ID: <d005a964caae7b9f7cccdc2092c37ccabb8deba6.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] wifi: iwlwifi: mvm: tell iwlmei when we finished
 suspending
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Emmanuel Grumbach
	 <emmanuel.grumbach@intel.com>
Date: Mon, 21 Oct 2024 12:48:16 +0200
In-Reply-To: <20241010140328.1dc3a7fea9d1.Ibf183824471ea5580d9276d104444e53191e6900@changeid>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
	 <20241010140328.1dc3a7fea9d1.Ibf183824471ea5580d9276d104444e53191e6900@changeid>
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

On Thu, 2024-10-10 at 14:05 +0300, Miri Korenblit wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>=20
> Since we no longer shut down the device in suspend, we also no longer
> call iwl_mvm_mei_device_state() and this is a problem because iwlmei

[snip

config IWLMEI
	...
	depends on BROKEN


so there's no way this matters upstream?

johannes

