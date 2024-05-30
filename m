Return-Path: <linux-wireless+bounces-8317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635A8D4E21
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 16:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B25281BFA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89BA17D8AB;
	Thu, 30 May 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0bNy4Pp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7A186E57;
	Thu, 30 May 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079866; cv=none; b=NXBvM0O4pm0gHNNyj9NVCagngWSZ/MMMhJfqb3uhO1CNWCsB/k/wv0c/yO0HxRBaEQ77kf/cV7hZhj9b6rpv06KMT9mzhTfHWh+k5THFwmZK/cMWLHU/B/0NEU9DpoeapLmRpTYopOW9zRYUEt87YJ3Yu5QKOgXvnMeqTfrgfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079866; c=relaxed/simple;
	bh=PrMYYh8kMW3pruikOzrJKUfG0y7L/m4AXDzs8y5gFXM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dU/Ta8KTRJTZN9gNXRobLGPnve65ZZxxGaPFHC7Aws4ghaih2uwvSRhV3sv885Dqb2KtZBPGlTd32zV+IvBjkzpG3R5VgvDyB+MNOjBPc+6JRiKC14+nrAfiQeSk+8l4pdOdDA8sT17aU+sAVulVFmmfbwDIdXay2yZUwpgWJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0bNy4Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEA9C32781;
	Thu, 30 May 2024 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079865;
	bh=PrMYYh8kMW3pruikOzrJKUfG0y7L/m4AXDzs8y5gFXM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=e0bNy4PpJtTgSF9gJUlNkBgM+IPi5zO/WvJd2wycEQrbq5uQnEnfQ/kNtqQmmj9Ux
	 uqAPiXXMEjvKmzL2faeDkUjO7ZqyHEgtyosglYwbE2ZNdcN+EAkA3QG4uki1DHMPi4
	 rILg68tyrzYfs8tWig6GHILB0XxehAGqLYZ57rfQTqeyW4vNp47H5WRgK5xFXD9S4Z
	 ecuxbsu3wcJ8cFPlBdo8EQXLy2t4oEsBk21xasonEHd+xHFM5nPgySSLRD5BIoXwnF
	 YK+iybUsD7etZDv8OuSdZPnsdJTM2ZnJzGVIPyKJraH/sFgMl1i9kkZYoYmojtQCtl
	 8jZBSroR2cdUg==
From: Kalle Valo <kvalo@kernel.org>
To: "Nemanov, Michael" <michael.nemanov@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,  Johannes Berg
 <johannes.berg@intel.com>,  Breno Leitao <leitao@debian.org>,  Justin
 Stitt <justinstitt@google.com>,  Kees Cook <keescook@chromium.org>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH 08/17] Add main.c
References: <20240521171841.884576-1-michael.nemanov@ti.com>
	<20240521171841.884576-9-michael.nemanov@ti.com>
	<cfe33bf1-9df3-4d02-b4ed-e29a430b106d@kernel.org>
	<456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com>
Date: Thu, 30 May 2024 17:37:41 +0300
In-Reply-To: <456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com> (Michael Nemanov's
	message of "Thu, 30 May 2024 14:54:26 +0300")
Message-ID: <87bk4nwekq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nemanov, Michael" <michael.nemanov@ti.com> writes:

> On 5/22/2024 12:46 PM, Krzysztof Kozlowski wrote:
>> ... > +} > + > +static int read_version_info(struct cc33xx *cc) > +{
>> > + int ret; > + > + cc33xx_info("Wireless driver version %s",
>> DRV_VERSION); Drop > + > + ret =
>> cc33xx_acx_init_get_fw_versions(cc);  > + if (ret < 0) { > +
>> cc33xx_error("Get FW version FAILED!"); > + return ret; > + } > + >
>> + cc33xx_info("Wireless firmware version %u.%u.%u.%u", > +
>> cc->all_versions.fw_ver->major_version, > +
>> cc->all_versions.fw_ver->minor_version, > +
>> cc->all_versions.fw_ver->api_version, > +
>> cc->all_versions.fw_ver->build_version); > + > +
>> cc33xx_info("Wireless PHY version %u.%u.%u.%u.%u.%u", > +
>> cc->all_versions.fw_ver->phy_version[5], > +
>> cc->all_versions.fw_ver->phy_version[4], > +
>> cc->all_versions.fw_ver->phy_version[3], > +
>> cc->all_versions.fw_ver->phy_version[2], > +
>> cc->all_versions.fw_ver->phy_version[1], > +
>> cc->all_versions.fw_ver->phy_version[0]); > + > +
>> cc->all_versions.driver_ver = DRV_VERSION; Drop
>
> You mean drop the trace? Will exposing FW/PHY versions via debugfs be
> OK?

I'm guessing the comment was about DRV_VERSION. We don't use any version
strings for drivers as they are useless.

BTW please check your quoting style, it is hard to read your replies.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

