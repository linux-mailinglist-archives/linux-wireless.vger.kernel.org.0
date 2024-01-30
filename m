Return-Path: <linux-wireless+bounces-2856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB46842F62
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97091284A12
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0A7D3FE;
	Tue, 30 Jan 2024 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="AZfKl1Cl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F17D3F2;
	Tue, 30 Jan 2024 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652574; cv=none; b=QNP/sC7QSRlNdjJ0kxhLJxGm0wJWFNdJQx3DDEtCEqFNWkud+TsOjh7gnDtMLJYqHm5beR3DOxl31JCuAeaf+GDbUQJRD3W2QQOzurJlWPVaL7rrT7okWWJFXj9zONmC/Jz0JqCyK4qbuVAWzgNiB2ChpuNHGYASJfjTcD4JSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652574; c=relaxed/simple;
	bh=FiA3NZiRrJyeN92CXtbS7FCHmwseVMJK5GqHs0nMFpw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bOBVyUGpWG9+8JaDDLTVN1qj8uUtqufuTOpA3P8Gfh5YuYLOYl33RX6xS6rcUcNji2HWHkpcuk37+nC8TQ+WL+RZI+FO4oPwODIcH/TvM+6VI9ED3gGibmkbFbqHoItfy6ujdQsXVBWjQDznp/F3iSteWsHxDP92L+gedwzqg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=AZfKl1Cl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TPfTZ6Cl8z9sV0;
	Tue, 30 Jan 2024 23:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1706652562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jEtN4ve+vVsn7PlNJhk+nSDskhUqzXKbr5NjxzzGEc4=;
	b=AZfKl1ClCnekmU3l+oaZxCuTc0EzgKq4LgKAwGI/ulfAB3tonJhU5V1+/A558LrfKtmK5T
	PYSTImhUkAtgdDz8Pjp4jCLG4QxRPqnHYtBBpdbQ3zcwmh5qSoWfzO/oVUxYTVFz7ChE+/
	9wwYglTweER2XKAWieLOdvM7zV/L/aUXDhZ0Db9tkAg34hQMu8tZ08a3EHCUA+aVpQ9LXq
	tR6CZZ21VR5GQBRADHhSmhhLKOIDIJczeMwcgX3s9/h+Cv0cGUevFZaJJqgz1jYijGcJ5J
	NDGfh0rhG5xRsePUtl8dyB+gvIiymBHRLMbEKRWWXE3Mk1seM/6jqcS9fF7IHQ==
Message-ID: <14959b08-35e3-4a86-acb8-04ee0a218271@hauke-m.de>
Date: Tue, 30 Jan 2024 23:09:22 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: backports@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: wireless backports 5.15.148-1 released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

backports-5.15.148-1 was released. This is based on Linux 5.15.148.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.15.148/backports-5.15.148-1.tar.xz

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

I am planning to work on backprots based on kernel 6.1 and 6.6. In this 
process I am planning to drop support for kernel < 4.19 from backports 
based on kernel 6.1 and later.

Hauke

