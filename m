Return-Path: <linux-wireless+bounces-29621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C32CAF78F
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 10:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 351033009817
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B37A21FF55;
	Tue,  9 Dec 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5qkNKkT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D026ED3E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765272994; cv=none; b=Wl5uncn2ckNKQe2WJDEXMW/bhgD3WcoXv9qoNtiBS3Qo2ThAOdIcXhElclLnXrH17KyiG917xwAt5FsaJeP4N8VuoaT6ktcN0N/VGAtYd5PokFybpX1j45TNP5rArUSIoPFxgkS21Z5hpqdQO4cx+oxjHfLBjPdakEloAIw651E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765272994; c=relaxed/simple;
	bh=EtxqSle8ZSFZ0W4tDSdVSueskSopxtabO0BIcYDR4GI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LOiiDKitY995ik/XpmG2u7TrfGG6itnH6MRnZvDwg/2rveDZ61XBKSVriaU8cSDfmqxwIaqZGr5/sJlhAxY+YIfHQc6eY4Vk5edCdpndu3MyVi6r66VM/sNVo2mQMRz4T3UL+BFerfos0Ez+eS08jPFE71kam96yrzdvTlhi9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5qkNKkT; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee12fda47bso11805281cf.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 01:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765272992; x=1765877792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WWH06oaUKu63G9r8jWKwgrermedfLot9vmh05q56ryI=;
        b=j5qkNKkTOV9ZHBvHElzLTbtR5O2JxWTbyS0jLwqEGjwmWPWUiPbPbRy1dGBaCxU1zD
         kHBjqu1YzpAeUdEqfcSlD9JtDp2opIby7pc16DNTFuZsk5ObpJJB33IgGeZ4ENmObUn8
         qTOOk3kZl6ziUSHA2YsrxApG6jpf63iKWvV3EGShfq5BybgCZIZzGOTy+Gu+Wy/Viap5
         UaH2ZTSSp28251nqXJoYzTi1IA6J7t3ojbtxaMGoqAe8hBRUfFtxeEmndvwd31oqBhoa
         Iei1Of1oE1m0ifMkDbP0aEE9FCrY0IdZYpVz7T76Qupyr0S8jSHghPxgfcRtzz/iQUff
         w3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765272992; x=1765877792;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWH06oaUKu63G9r8jWKwgrermedfLot9vmh05q56ryI=;
        b=BTnkSz8JoxoM4t+RQsExMUVudY+qj0edy1iz/0svNVUCx3L+05iDjBwlSwWYCJ65rk
         xOVnjlWB7rzYIb7anOo+PGGzvp/XZwBiMm4fZuJDLdNTNR2/zPxTlZWzB506qdqcZWpy
         ihYHfPqYuVR/60ZO6+cQ7fEbPqjLadYO0JfVEs6DTEOEMwCOsJrTV9Adv1Pr9Qg5EpTc
         nm3vltxnL/kwgReXt49oGmSkUxMN66cTIUE0wUUitNWqC+M8u/CtDNm/i0BO/aNXMRp9
         X2OpVneU1fXWw3sYYNeAxHVhUsFM1u3nXhTVLqDGy5ynxaoC2kB2kObhdG2pxLrQeG2e
         uLFg==
X-Gm-Message-State: AOJu0YyYnQ03hW+RedmOI3J6VBuulc3JBjwD1Pyqfvn7A65+90EzbL28
	BjsQ38xoyNOBlRTmgYAbyE8Wo9yYnZPcAvtamks3SGxb/KYnvzBQ2Fv7YIpQLVD1ufSclgsSoqO
	Ivd+ABp2PErUsNuOI0csbGbNVPZlQ6Vs=
X-Gm-Gg: ASbGncvgIU+AY/4e2KFsSTtYEMDrmWtQKVYYU82Ko4OVli5/E+vdg24lLVGpc8LKsaT
	lrUyi7mZrC9pZIL5AWxLzjFB8EnTmlug5KDW+ZJFADI+913FNQDB178xDMqwY6RwEdTI49S2DPj
	bd+XC9jUZHeIKPNYWG4HuAIpc1RrbazL6Qr4EK7EUqYha8fGD5NpbFmtVPI/PGpBW1Ui5uCUhJ8
	GFVuAw9rNfEOuGd8ElXJgUddr6F2CskwGoQqTWl0+IlLEU/93w/uexaLGCtXhhbcHxZ3Mjv
X-Google-Smtp-Source: AGHT+IE1bm3CYqtbybMIp1q1E+Hd5HXY5/HAVpl9/KZ/pb1kJfRLV4Oaf/eZrqB34ZTL71LRKC+hG6qLaXODIhcLxmw=
X-Received: by 2002:a05:622a:509:b0:4e6:eaff:3a4b with SMTP id
 d75a77b69052e-4f03fe01b6amr115034141cf.4.1765272991668; Tue, 09 Dec 2025
 01:36:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: feng xiangjun <fengxj325@gmail.com>
Date: Tue, 9 Dec 2025 17:36:20 +0800
X-Gm-Features: AQt7F2pWs9V3rWgdDzOOcO_Fs6x9MCmMB3v49VQls8dEnF248bV6Rh_oUAHULck
Message-ID: <CAHH2t856Y3_dYUPhN6s1X50gaWXPzEwjQXr3njvudJzw8FFJ-A@mail.gmail.com>
Subject: Linux 6.18 breaks my wifi 5100
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Miri.

Just upgraded my laptop from 6.12 to 6.18. And my wifi failed working.
Dmesg shows:

Dec  9 16:01:55 darkstar kernel: iwlwifi 0000:03:00.0: Driver unable
to support your firmware API. Driver supports FW core 4294967294..2,
firmware is 2.

And 4294967294 is '-2'. Strange ...
So I changed this:

linux-2.6$ git diff
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a607e7ab914b..2dc0d1821f6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -234,7 +234,11 @@ static inline int iwl_api_to_core(int api)
        if (iwl_api_is_core_number(api))
                return api - API_IS_CORE_START;

-       return api - API_TO_CORE_OFFS;
+       if (api >= API_TO_CORE_OFFS) {
+               return api - API_TO_CORE_OFFS;
+       }
+       printk("api: %d\n", api);
+       return api;
 }

And reboot. My wifi works!
Dmesg shows:
api: 1

From commit 5f708cccde9d1ea61bb50574d361d1c80fc1a248,
This will never happen? That 'api' should always be greater or equal to '3'?
But it indeed is '1' on my laptop.

This is a very old Thinkpad R500 with:
03:00.0 Network controller: Intel Corporation PRO/Wireless 5100 AGN
[Shiloh] Network Connection

If you need any other info, please let me know.

Thanks.

