Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D482396DD6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 01:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfHTXhi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 19:37:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42397 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfHTXhi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 19:37:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id t12so812989qtp.9;
        Tue, 20 Aug 2019 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vA+qIYGtmiBVWFKNi042FkOFNwyhlELwadf0fyR1JvM=;
        b=q8KfdDMmqOpQNfQYc54DepOLtv3/x230eoAoDkznTLT3U2MHcHfVmumg1W0ZxYZJBV
         Zgno3LwZ7CLZIiaSoGmp1z+vzHOVBBuIj6yX/mJydyZYJXa54NMaDcPyyukTNE2rDiXH
         hu5/RK/jOYm1BmAG20Tuv/2MBS8Jxxqw5RslsI/bhor0bmAsqS1bcb7NaCOWa9jtOK4J
         vwJTH0kAMaapIqnXklZvvx5Md3Y7cCSPWLyZF240pscAw9uYWbFqOsTfXYNmcRxnXuDG
         5rKuSlUsMQ2pbMy4npHjKnR6Vb+XgZh6tKwTBEbAL+JeJ0LOz4Z75A7M4TD9CwMK3ctI
         VKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vA+qIYGtmiBVWFKNi042FkOFNwyhlELwadf0fyR1JvM=;
        b=ogrUTZ7Ap6M6UEB5Ls2mmRw+h6fxQyICcGG11JqCkkKPQrtik4y8/mN9xuQHNG5WNI
         zgUdzf//AtFoQADncA0QvKYY4lMVIepDYI5qkFYY2xhSkrjCVKVteJWDqaQI5UY5yU2q
         tSzWSeiz9wkuDmbdevqCxYq3NlflYVxnrdYKgm9LAZs3ykLhP0UCaUv+GiVUWtYvzq5s
         ydtXDPkhX1/s6YipT/YF7wi1TJApYxbduxkqPgT6MYfyGz3QrkAV6tSkPJ6goAirq+81
         K1Yghpglx2OmI02uq0xf6yw6TmvkvRvneaOlw4K5rMQDwcu7WgoaghiZyh8fZQsTs644
         syMQ==
X-Gm-Message-State: APjAAAXRiwVORq5pN1WckCNsWMH/m0QdDwNsmEvNgHe75uFayB5Qd67O
        87Ye0zL24qCZM+HvBCrCOXQ=
X-Google-Smtp-Source: APXvYqylevPFkTKrNgzNE1LJCY3y/vdr8E4JkE/U92z7RMRMnmuxVtiy4pqwa5jfSfIPv47Tt7GgFg==
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr29166718qto.249.1566344257034;
        Tue, 20 Aug 2019 16:37:37 -0700 (PDT)
Received: from chirva-slack.chirva-slack (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id q29sm10724740qtf.74.2019.08.20.16.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 16:37:36 -0700 (PDT)
Date:   Tue, 20 Aug 2019 19:37:34 -0400
From:   Stuart Little <achirvasub@gmail.com>
To:     Luciano Coelho <luciano.coelho@intel.com>
Cc:     Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
Message-ID: <20190820233734.GA1406@chirva-slack.chirva-slack>
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
 <87y2zsf9ps.fsf@depni.sinp.msu.ru>
 <20190817214448.GB1070@chirva-slack.chirva-slack>
 <1b1e573e6502c97851838a3b27ac0b272198926c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1e573e6502c97851838a3b27ac0b272198926c.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 20, 2019 at 01:45:37PM +0300, Luciano Coelho wrote:
> I'll have to look into all NIC/FW-version combinations that we have and
> update the iwl_mvm_sar_geo_support() function accordingly, which is,
> BTW, the easier place for you to change if you want to workaround the
> issue.

Thanks!

I didn't quite know how to interpret this suggestion (i.e. what the change should be), so I was poking around in there out of curiosity. One simple-minded thing that worked was to just pretend that that function always returns false:

--- cut here ---

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5de54d1559dd..8c0160e5588f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -925,7 +925,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
                .data = { data },
        };
 
-       if (!iwl_mvm_sar_geo_support(mvm))
+       /*if (!iwl_mvm_sar_geo_support(mvm))*/
                return -EOPNOTSUPP;
 
        ret = iwl_mvm_send_cmd(mvm, &cmd);
@@ -953,7 +953,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
        int ret, i, j;
        u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
 
-       if (!iwl_mvm_sar_geo_support(mvm))
+       /*if (!iwl_mvm_sar_geo_support(mvm))*/
                return 0;
 
        ret = iwl_mvm_sar_get_wgds_table(mvm);

--- cut here ---
