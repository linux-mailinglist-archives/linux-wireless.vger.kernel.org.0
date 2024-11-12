Return-Path: <linux-wireless+bounces-15196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098289C5267
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 10:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF992B2AA7D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E020DD47;
	Tue, 12 Nov 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHX3PZKJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647120E014
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404670; cv=none; b=UCUlBKOlmCLZgJWph03XZbfBPY2dm5IIcgBgCbCgIe7zT4eIRjOi5bFuxoJHH6KPTGVqbxEC/IJhWAlyqcfMOMMdQ8kUHFDqOu/Yn2Eaki3G+skh9ZKnOl6awIL0vpSd6wlX+9QEtY3BNOD619hyGpTQBzaLp6iqLtqLkJuvyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404670; c=relaxed/simple;
	bh=tLX7hNz20UkqIisLL8tTsK1dmqtAPnUeIMe0aEcRTms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U2Hjags2CgyyOzzKkLnVmztk5a2n059rwXiOqLYcG4oY9+/0qk/PKayC6cfoAbZZIOmXXdwgFqPHjAK3cOLGn2nDPE2e85+foCaOyOyA7G9c57GBKICFiOv5vVwSUB2EYDZRe5HmzZmEKFTlilnuuMz4t/WwSmjJFYbY0UAIgWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHX3PZKJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9acafdb745so1073434566b.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 01:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731404666; x=1732009466; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOZcHrrwK28eiEwtr5E4X640z6323UJb7P/D4dzaIWs=;
        b=cHX3PZKJOaZ5fixUgW+NJ9IvLHUAEf824YXT/OPU9PXvlu1Wv1mN4fHyZYpr+cTmvz
         zhpsbCVtA//ut4zL+Rj5csn6C2FQ7HspNqKq5ccnX9go6zso8gUuNWGErJAIMJ4VC6HA
         Y+9HH5plrNP8StNIVPaW5ig8AJ8JoYGBW1OUOJzRCKuOgg7i1wA4+O6B63qDj2vqRRGX
         9aJzkCqvV3/set419xLd9cMl2jLC+Fy3v1WYBO1X6dPD32DdFAisv8zRpZebdVJGxqwI
         FhY5gBBRQPs+u8CsSrSsdkDkBPrdk8GAkqlxzdAU40BbpFeXPHrqixgyHu7KBpkKT/ck
         n11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404666; x=1732009466;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOZcHrrwK28eiEwtr5E4X640z6323UJb7P/D4dzaIWs=;
        b=qrdxiFUaBs952+uhxGzw4pLRRzqfMGCymOlMXoh3pMMEhamwH5AMnIcpIbCHLS/p6Y
         Tf3+lQN47TcQZ+X1EQGb9TkKjcqYnwsSj5eMJu1ZyTG8McVWo9k+HEuArL3bQDg3EShq
         Vk4qDtm2rwuJO0UQlj2gz34mcmoAtRIEpLpc4ySuubYL+yMSb53E6ZnQZNhbtc2lMNPp
         QxBJETDzTnStqAYKGeuEnax27qRl6g5t4A+zYH72T5RZe5O3hqOgdGe/7WNp5lkpJy7q
         fJDH+FbVZVtdqL22abmKD+IIQpuPYEpkW12v4876vpfncZ63Jw4Gh1257AUlGNI+FQsR
         KJkQ==
X-Gm-Message-State: AOJu0Yy9zkFfECPLwzgqC6IQ+HqA18+mQuGemO8CFgEGmLRmtOhMkjgs
	mTNpJGAYqzRKV7SZhMygCFKEuWQ4hR8YqlB1KBqiQPEUB04QKS+fOmsK8HBIH2ztFPZg8C5IzyR
	J
X-Google-Smtp-Source: AGHT+IFa1NJO0iQ7KnxsdSofjFR9nJZle5PpiK1iSj/wHH2HIDb23rAhznCFsc/oEVZNTnuYtMWD5Q==
X-Received: by 2002:a17:907:72cb:b0:a99:f5d8:726 with SMTP id a640c23a62f3a-a9eeff97ef5mr1667429866b.23.1731404666499;
        Tue, 12 Nov 2024 01:44:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def900sm699310366b.147.2024.11.12.01.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:44:26 -0800 (PST)
Date: Tue, 12 Nov 2024 12:44:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: support fast resume
Message-ID: <c6a40af0-a649-4f9d-9245-dc6d6381cc10@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Emmanuel Grumbach,

Commit e8bb19c1d590 ("wifi: iwlwifi: support fast resume") from Jun
18, 2024 (linux-next), leads to the following Smatch static checker
warning:

	drivers/net/wireless/intel/iwlwifi/mvm/d3.c:3121 iwl_mvm_check_rt_status()
	error: uninitialized symbol 'err_id'.

drivers/net/wireless/intel/iwlwifi/mvm/d3.c
    3112 static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
    3113                                    struct ieee80211_vif *vif)
    3114 {
    3115         u32 err_id;
    3116 
    3117         /* check for lmac1 error */
    3118         if (iwl_fwrt_read_err_table(mvm->trans,
    3119                                     mvm->trans->dbg.lmac_error_event_table[0],
    3120                                     &err_id)) {

iwl_fwrt_read_err_table() returns true on failure (meaning that we weren't able
to read the error table so maybe that the two errors cancel each other (double
negative) so there wasn't an error?)  Anyway if iwl_trans_read_mem_bytes() fails
then "err_id" is not initialized.

--> 3121                 if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN && vif) {
    3122                         struct cfg80211_wowlan_wakeup wakeup = {
    3123                                 .rfkill_release = true,
    3124                         };
    3125                         ieee80211_report_wowlan_wakeup(vif, &wakeup,
    3126                                                        GFP_KERNEL);
    3127                 }
    3128                 return true;
    3129         }
    3130 
    3131         /* check if we have lmac2 set and check for error */
    3132         if (iwl_fwrt_read_err_table(mvm->trans,
    3133                                     mvm->trans->dbg.lmac_error_event_table[1],
    3134                                     NULL))
    3135                 return true;
    3136 
    3137         /* check for umac error */
    3138         if (iwl_fwrt_read_err_table(mvm->trans,
    3139                                     mvm->trans->dbg.umac_error_event_table,
    3140                                     NULL))
    3141                 return true;
    3142 
    3143         return false;
    3144 }

regards,
dan carpenter

