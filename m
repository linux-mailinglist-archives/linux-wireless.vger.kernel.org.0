Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3173A37F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 16:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjFVOrs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjFVOrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 10:47:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90D71710
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 07:47:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa71db4208so8535635e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687445249; x=1690037249;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJYjzoIWILoYD4M2I4Y8Zk3AWtuJ/URIlwu5Up6nBZY=;
        b=FhheVUIjJYSb5O2QwdZBZVBHNT3FGYxH70psi2UHulqKmntmNqzAASKzFtz1X8Y5NT
         XzTKtoZLmFxYQPOXH1Nw8yaGl6fhiVJ4IJCloa96UKfJt7OwLCINuc+MxE+95I75/rBY
         ajfoCOidJJ1S4k+74+J9iZA61MhDDO53yjITz7Yp5FhKkZ6TuU24WZVnzWtDDIpTPRzm
         waDolHj99v+JyxUjsXjitMymlDOh5eI/s13iZqDcz4djvvPZXWr5w2/XfZ9ZUBDKKaqT
         GTb0bZ69fy76lJrSNmuIb2jRqa8PQR7zEBc58VE+D0XRF6HYLFTzkdSDN0jLcF6oZ1zz
         9moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445249; x=1690037249;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJYjzoIWILoYD4M2I4Y8Zk3AWtuJ/URIlwu5Up6nBZY=;
        b=jFvYotWBlH4iE7sgjgyw1xTG2V6+RbVG9v1Ae9VTRc45jugqKmcW32xixYCFNiiyAw
         25zkJgpZQsonYiFFprk3GnyEV+oVL3oG9qdgEUjQZ30lplE+H3XbqkW8QKLrq+msJpDd
         9Va0VcjbqF2T2toFEdKy0DXO8PxeK2+G9t/v+y3VBnje34Fj/GCYmdrnIyK1DmU7WKkA
         7GwpCmvfClA1UoyCd5hhdecHsHqWE44iHnuBWtE8CKK/TrW9QYI81VFVxu4R/8IEMFxY
         r5nnzpdf1xAkznat2cC5u5mAnLSWUJKOa/dZl3E/q25iiTZFvtAWVTaT+b2sb03ACMOM
         PaQg==
X-Gm-Message-State: AC+VfDzAORmnJZWh16lqNg0ol9Ja9YIR5i9M1esVLkDb28ouzn9D1V83
        DyNoYzl4AO1xO5j5CnnhAEUIfel2Bk4uvlACQzM=
X-Google-Smtp-Source: ACHHUZ5oht0vWMikWC6Jsx9F6qX288zTDOSsYZGZA3svsjKd5P29k4/OXpGz2NbcsHn7sPPwoa9NzA==
X-Received: by 2002:a7b:c84f:0:b0:3f8:fed0:1c5c with SMTP id c15-20020a7bc84f000000b003f8fed01c5cmr2087883wml.8.1687445249129;
        Thu, 22 Jun 2023 07:47:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003f907bdeef3sm15174961wml.26.2023.06.22.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:47:27 -0700 (PDT)
Date:   Thu, 22 Jun 2023 17:47:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: mac80211: store BSS param change count from assoc
 response
Message-ID: <1c031edf-a2ab-4548-a181-16b8c641d786@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[ Unpublished Smatch stuff. -dan ]

Hello Johannes Berg,

The patch 5c1f97537bfb: "wifi: mac80211: store BSS param change count
from assoc response" from Jun 19, 2023, leads to the following Smatch
static checker warning:

	include/linux/ieee80211.h:4924 ieee80211_mle_basic_sta_prof_size_ok()
	warn: duplicate check 'control & 1024' (previous on line 4923)

include/linux/ieee80211.h
    4901 static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
    4902                                                         size_t len)
    4903 {
    4904         const struct ieee80211_mle_per_sta_profile *prof = (const void *)data;
    4905         u16 control;
    4906         u8 fixed = sizeof(*prof);
    4907         u8 info_len = 1;
    4908 
    4909         if (len < fixed)
    4910                 return false;
    4911 
    4912         control = le16_to_cpu(prof->control);
    4913 
    4914         if (control & IEEE80211_MLE_STA_CONTROL_STA_MAC_ADDR_PRESENT)
    4915                 info_len += 6;
    4916         if (control & IEEE80211_MLE_STA_CONTROL_BEACON_INT_PRESENT)
    4917                 info_len += 2;
    4918         if (control & IEEE80211_MLE_STA_CONTROL_TSF_OFFS_PRESENT)
    4919                 info_len += 8;
    4920         if (control & IEEE80211_MLE_STA_CONTROL_DTIM_INFO_PRESENT)
    4921                 info_len += 2;
    4922         if (control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE &&
                                                                          ^^
Should this be ||?

    4923             control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE) {
    4924                 if (control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE)

This is always true because it's checked on the previous line.

    4925                         info_len += 2;
    4926                 else
    4927                         info_len += 1;
    4928         }
    4929         if (control & IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT)
    4930                 info_len += 1;
    4931 
    4932         return prof->sta_info_len >= info_len &&
    4933                fixed + prof->sta_info_len <= len;
    4934 }

regards,
dan carpenter
