Return-Path: <linux-wireless+bounces-3329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C884DDF4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 11:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EADB2924E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E16DD0A;
	Thu,  8 Feb 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDcB4PpD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836986E2AB
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387458; cv=none; b=LUsmMZ5rMMmNXXy72vfZ+jrqTdFvmCn0smBF2wACbBIX2YWjZgfdOHrqpq0N2sAOnY1mxvTpA0S4iV1mu2Z7lia5z5cnnNhFTo0OP7ej7P2XR5tB1kKElPkuw2wdbvPPCXrkVtTn36tUTMPByNV10zCzBPfWj5m5u+I/GfyZjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387458; c=relaxed/simple;
	bh=TqMu84p62go2ECAjuTKX5lC7+9a4OPfiRFRt5ZFApA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D3F18oehmpUqtJjIpqqgIk2Ynn/t+h/m6oXSpdJndr4CP+JkKG54DoMrO+w7CEHzNs0QipmUQIq7YGAEJj1Z4fe/ycBwXsGhdQxooBPrkD/fzCNcjlTAZKsv03E8+4nCG3+fSvjYg6GXSWkArLRVPJUaBf423p/5/Zsb+tu3BGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GDcB4PpD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5601eb97b29so1401019a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Feb 2024 02:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707387454; x=1707992254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mExta14h3FfRuo79nR/+ky5h2A6/maxcVWEMwCpWnDU=;
        b=GDcB4PpDjORSHT4pBwsomRTCG42odWQd08Y/VyEK0SryNql9mvXetDAqztU95XtA6Z
         w5FrTrzj/KL1uNPOm5yX6tSZx2K2ePAQEPDEZWYRuzwbo0LVkpw/esW1wIEaVXRWZ5ny
         r90EAEEaSyWP7yd3Imspbgand6IMjxjqhUcozV5SQ92F8NXRlbmRh1uV2FDG5Wo1YOoH
         p3vYB4IUzxVnq4/U0Cw3jEGdFbpsVsPWd9S9O3hww5TWnhNyJTcz5DPDVmnS4KguaZJ/
         EdUJpgcxJpUFpYafLPLYxRa+65T7e+QujNaoHV8MclshhnPBQ3NQAbzJjXPEMN4ffWV4
         DjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387455; x=1707992255;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mExta14h3FfRuo79nR/+ky5h2A6/maxcVWEMwCpWnDU=;
        b=YUW/oQhqDkBWmzuZdl5PL8oml7afuZNouZ7faSOPCZjRkXF65lQ4A8MsTX+d5VXvce
         sSASFSNCz3zlMdQWnW86TJ5BNGizuQZwETRjAd/OX0xF/9S/Yu85BOrhlVyv3kPQSEA9
         3RbzIzoTEImUfg+QKDIjquXtasptKmJHXFj0/PMZSwZaY3Oy2C7L3LWcPdJ0k2n4BN3P
         RIwIGvtpqX+wf1jvu9epY9uL+f+WlzlPxJHmirpyMh1acE+z3Jb2a+wH7fFmG+xeNZL4
         kSB9sR1jKHBlNv73LMNG2a/TCHFdqU+GzESqqIvqkXy28M0NN2jTcwO/aXNjzNENQJt2
         3AFw==
X-Forwarded-Encrypted: i=1; AJvYcCVub7cvkc8KUxrPpcNJNAPXD6ldS8Fx90jSuW0JPTfKmc9RdY4E7trDhUQ3Uz4+5WTaLNeXu2LnyxkTxPIJSztkEHtmhrEk53lcbNTc5rA=
X-Gm-Message-State: AOJu0YzgvEArATSZE7asDgzXKOVuO5uFBuTmwSr0MtJWL1HnBHPGeEQx
	gStCQcv/mF51P2/N3yl0op58jhIOZJvHW9kjXy2SsDs8ZPQumjIOSi7sTu8AErM=
X-Google-Smtp-Source: AGHT+IFQx6srRh7zgGl8duv2aSjEJvDZQ++1WrbUI0C9W3RKZcrZvqb9vQvs8q9ELhOdvjzgZEUn0A==
X-Received: by 2002:a50:aa96:0:b0:55f:ccb4:ec84 with SMTP id q22-20020a50aa96000000b0055fccb4ec84mr2314443edc.1.1707387454717;
        Thu, 08 Feb 2024 02:17:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU41TDGHT0O3Zd4pv2l8cH4j6BtQDwfNy5O8SMYC/4cRdl+FDAuYn1N4inXencM9KSIJQRYVCXNvB1oqaHfNcwSE1OoL5Eh3mOfdxHndzcI8lPsXHUg6W5V5t3zFqlJ70J0VKSUHIeeq07rkaxcCtQkfTNRwFkEpJABpKbySvWpyZkDop94PVG6/C2Ok4CpbGoe/v9zQ/Azi5iIJwIMm3Yo0p/CEfAGbt61tucEf4sTwptF0TTNYnwxpq4PWB+eZQkYjyCrKCevHe1xdYM5fEL092N88BiajKxQWJ4AN+wtbu1Bt1ZXuny80ao4XLnCDM+aVKaM4loTW2DdzPTUoJgJMcvihk0a2bDIWzTwvQy2CWUHHHtP+Oi/TofHRN6Hg/5CKWVBCVAZhi+R57MWWav3qbuTncqAVNJUWubjybh0cZYAh7CQr/jN0BHQDSSHxgfWsAIaPruuR1BRdQ==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id en14-20020a056402528e00b0055fe55441cbsm663142edb.40.2024.02.08.02.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:17:34 -0800 (PST)
Date: Thu, 8 Feb 2024 13:17:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matt Chen <matt.chen@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Alon Giladi <alon.giladi@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] wifi: iwlwifi: uninitialized variable in
 iwl_acpi_get_ppag_table()
Message-ID: <09900c01-6540-4a32-9451-563da0029cb6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9620bb77-2d7c-4d76-b255-ad824ebf8e35@moroto.mountain>
X-Mailer: git-send-email haha only kidding

This is an error path and Smatch complains that "tbl_rev" is uninitialized
on this path.  All the other functions follow this same patter where they
set the error code and goto out_free so that's probably what was intended
here as well.

Fixes: e8e10a37c51c ("iwlwifi: acpi: move ppag code from mvm to fw/acpi")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 506279b95442..6806ac1636ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -848,6 +848,9 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 		goto read_table;
 	}
 
+	ret = PTR_ERR(wifi_pkg);
+	goto out_free;
+
 read_table:
 	fwrt->ppag_ver = tbl_rev;
 	flags = &wifi_pkg->package.elements[1];
-- 
2.43.0


