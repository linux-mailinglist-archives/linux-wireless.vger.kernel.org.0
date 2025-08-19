Return-Path: <linux-wireless+bounces-26461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0852B2C9DA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 18:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F98716CCEF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD825A630;
	Tue, 19 Aug 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l2k9aXPk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F225229C;
	Tue, 19 Aug 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621347; cv=none; b=VPv1DJ5X36pMJYIdgnSF/QJD1mZTaT7c5kE8vE6cKSKShLkapg3PdFC/aGrji+FBxHjFOzo6OyBRKCyreUGitaqQTson7ADhC2Zz/VwLPoG6yHGNNFA0rl+NBSF4Rc9pcPPcAKd2MozRmwicacBit5yH2OkdfGvywg7FxbXLgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621347; c=relaxed/simple;
	bh=uysln2twkxjwyTabZ9B7JuHAbGVUHD3aOdLHQEg9RSs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GQ1VQJrJjUxaLCfUdrF647+TLdFs0rLYdjUvkGyr3IJP/vG8Lj0BiNRs6jSngoPNqXiyb9sdtuuCk7dTPK9vouM9X8j91sn0m2apU33Lo4Xyq5itKgSK2INb5BB7fhIMdXfCGph0/cLgPI4M+vNWjXiQZJnRHHryqRIdjhs3KYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l2k9aXPk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755621331; x=1756226131; i=markus.elfring@web.de;
	bh=uysln2twkxjwyTabZ9B7JuHAbGVUHD3aOdLHQEg9RSs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l2k9aXPkzV8NAENmQPAXi+lwB5Hu/gJQ5t16RQRwWPQ6B1CEGfLHHmzwcPlhOsl0
	 X1XhMrkBirMmyfba5bEfFGyHiNEKH2xMdQEZm1rG7i5EGHrAoaUhsyoM4RafaU4EM
	 5/GlSvpBOAoIe1jbBoAbSsGxjL/BCl2Y5i825s241N+RpLdv4PAtna0akkpJmSYfW
	 gXzUwPdZnH+xWO6UsnbiWRmh/GulXWYCEPAps4ulEip6gNawZ9MhmC0IMSdd8D9Mp
	 4Fjl9EQy5f+OqxzWbFpnyK8bM4UPU0We0+q7cEd6absUZGJmKgTmiqbM7MQR3AlWZ
	 7r/CDT/qeD80zPM0UQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1ut68I2N3B-002hLC; Tue, 19
 Aug 2025 18:35:31 +0200
Message-ID: <ddc9ecc1-ed1c-4416-ad5f-5f5c4cb72564@web.de>
Date: Tue, 19 Aug 2025 18:35:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 Rotem Kerem <rotem.kerem@intel.com>,
 Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>
References: <20250819121201.608770-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH 0/2] wifi: iwlwifi: Remove redundant header files to clean
 code
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250819121201.608770-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1Jgv37srZjxGapamfKdetXLYMYymgfEHArR8vecWbe2GP2JfUkv
 Ep15pTpfWs0nDpzPyqCrnnVxt7BlHHygpDlFsEbL9/+0MYWdDqp5rY9M2ioFGc7Z0e9UMN1
 AVJxe3Wbbv9QZdDc+O6bc2AJdsfU/HqK5xApLvRKsGPJGheRJSy89JnwrFPrkKbNph0ih8H
 zUH7/P+B7oFetO7aSLVLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GBd1cWIr8go=;kxCQATS1eZ1AP5+OBgkNh23dvyJ
 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
 lZpnRcDm7bwi6WNmjxE77AZp+OhI

> There are two files with duplicate header files inclusions. Remove these
> unnecessary header files to clean up the code.

You would like to omit duplicate #include directives, don't you?
Will corresponding refinements become helpful for summary phrases
and change descriptions?

Regards,
Markus

