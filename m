Return-Path: <linux-wireless+bounces-3328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3616084DDED
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 11:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF73C28A53C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAD26D1BC;
	Thu,  8 Feb 2024 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ohd164C6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A136D1AD
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387433; cv=none; b=j7T6iXUEkHgmp/wmmxUzsUtL2a9G9jYuxsrPZWqk1Gq4oV1+dTqF+ZnPTHMLKyvleWTKLg4HIQGSmS1kiCo3Cc4xGoOTATKGvNMmiHPpcAlMRjgnzwwQ4FtB6MWb6Gw1noVBhqkwFGvDidKurIExpOqLo/OZJlgUzcQ9SBq8MRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387433; c=relaxed/simple;
	bh=84Kib6khEPlN8l9DaFkQuhMzge2xCeFF//MaGpJ0yqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mB1F0OzuAtj/czdTEV15UOyZYhmoUX/g5yXGrZNzd+YeLJKNW77aOARYSW9ubHUK7XhRHNxXGZSYLBMOiey1dlEd45GiHbnQ2IOfCpPyWM+GwGy5AKMELcjSkYpBKmOZhpgWJ6k208VCh93LnTilFdXZZSngHwCy4KSnNNxHKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ohd164C6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a37721e42feso202430266b.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 Feb 2024 02:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707387430; x=1707992230; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSCzA3TtajxFSnQT41yvEgUpa+RWk4jWwMsKck/Sxug=;
        b=Ohd164C6BH8Uaj+0a5Y2EKVdnqMdDhih2l5mC7BszLEdGIdeGXZ9QTops3R3wgC843
         vRYNMOOl4s9Be77sSjKNwEPuPCiXUkywsXGbjvFtLHlmdYDckUjDWKr4o/UkDMqwvpu9
         1uTQCA9DURbM9OjxVw7ExhHjwPOwv4G21HzUNmp9qqDvy9U1dhwlzYi3FcXRBbth1T4w
         8VXzP9HFSN6DBoejpp5IIiTnRLYYrmVB7Ti4kNLaSym8mqeoboyGHQKC0y0N7k2wtNXT
         IW8v1ARIGZZwMLOSN0JCPWS6bTM36GJ9KuAUwnsYPyHfwSxizhbKC+fARSndcfk684Eq
         xsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387430; x=1707992230;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSCzA3TtajxFSnQT41yvEgUpa+RWk4jWwMsKck/Sxug=;
        b=ajk9s+gmKCWbZAOdEDyCvmK18Fzzh2pvsP1fs9QtwRrLLFSajpjEBuUUg1yszoUYbq
         QK72FjQh5NmCMCZcv8cu0CGPx71/2y1oQqpBepotjl1oMF3sGdGRzaJ4Hdhe8S4X99B9
         wV7Ng5XtMcUkB/PSmy2mUlaW13+WhzfT+5KK6iixMcLO6dcLHeFzZCW5qWjccKh1xdLy
         uf7V1pMhinn72/qQiqB0fRd1f2WOmFPWfhqFzfSzp6MU2peDfxNZFsUUJfqhIVTifaHd
         tnc4fkDU1l+XHbMuuQ+FZ+MKMXJL9poAGsUkyUvIIkKN73mRKrmFMqjvyTFDnRj3xjCd
         7tug==
X-Gm-Message-State: AOJu0Yzgii5BDwgfQip+EmF4CKM7lCrI4gDgYyhR1qFGXACV7OSqBqLR
	oxf5uOHJq7yFIxYIXC9WfrT4retSKXkUX4NvHeL/0rD3lkaE/PI0DNm5EuQQ2zA=
X-Google-Smtp-Source: AGHT+IGoDK7SVa0dMNt4YRGN7S5DNOa0d7ywiVZeynjKlEfCY1x5p53xCugngv+0LbXeCiY5hquXdQ==
X-Received: by 2002:a17:906:2111:b0:a38:406d:5dd4 with SMTP id 17-20020a170906211100b00a38406d5dd4mr4575288ejt.36.1707387429815;
        Thu, 08 Feb 2024 02:17:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqKVQGhK8sUJu0fES0yOgITDofk1UNiJVOH8Sce42i+S+Uy+ns0sufGciH3z7L+1Wi8Xtd4BcYg90PvaqaQ9XgN0K4DBOufSnPjP0uhvngcvJxwJhXWWAfBrouK3T7SwF3fH2ddn46GGMmXAPqJpkyJ7BBlo56i7pOu+fCawbVtltmcOVyEhcReg+dEYcZVwHqnj0YiJnBjqCKGYtLyb7BF0Z3rBGOTDe2DXu3ipoE2vUIMllvEluJXkBHivuCJFLYDV8RUNhtxO8JuooiGJftmo8p0NEkQ36ZYloZ5+VyIQle2yANRoMWWvmOPLPahmnddFAw1W+ZReF377+bC6ApoM7C1qqywfdKE9FfkFFEDu/w/5xaLeU1y9HRCNW9kgGiQvAyIPry7YhAKz/vrs5/LFnF4ApCZHd9JTzmwRc/qlA=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id vo3-20020a170907a80300b00a381eea0e9csm1736957ejc.197.2024.02.08.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:17:09 -0800 (PST)
Date: Thu, 8 Feb 2024 13:17:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luca Coelho <luciano.coelho@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Alon Giladi <alon.giladi@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] wifi: iwlwifi: Fix some error codes
Message-ID: <9620bb77-2d7c-4d76-b255-ad824ebf8e35@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This saves the error as PTR_ERR(wifi_pkg).  The problem is that
"wifi_pkg" is a valid pointer, not an error pointer.  Set the error code
to -EINVAL instead.

Fixes: 2a8084147bff ("iwlwifi: acpi: support reading and storing WRDS revision 1 and 2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 9afb1b1d6aea..506279b95442 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -475,7 +475,7 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 2) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -491,7 +491,7 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 1) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -507,7 +507,7 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 0) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -563,7 +563,7 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 2) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -579,7 +579,7 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 1) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
@@ -595,7 +595,7 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
 		if (tbl_rev != 0) {
-			ret = PTR_ERR(wifi_pkg);
+			ret = -EINVAL;
 			goto out_free;
 		}
 
-- 
2.43.0


