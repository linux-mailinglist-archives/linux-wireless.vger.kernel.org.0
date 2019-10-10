Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3077D1FE9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 07:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfJJFKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 01:10:19 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:6050 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfJJFKS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 01:10:18 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 01:10:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570684217; x=1602220217;
  h=mime-version:from:date:message-id:subject:to;
  bh=JCsL3WIN73xzwLhXOrKo3QlppAA/heL7UqOSuoxaqtM=;
  b=pkSl9+4y7K/NCCI7wXdy9BfSQPf2O4AeGhttQ4to4y+GkSEmrco3Ud86
   05uRT8yxED5e4ExVsZeVi2H9zWxARQDagJ2ZhCJWVvLD+wpSUjHbuoIQs
   ez/+mzJponVdhqS2Ayk2GSjv/7HZHXnRWL51EBZlUWLJdtoFDbLWJ+bp8
   iyZHBP0rza220ZjKC2QYMYzBnBwhVQWqxYds++zjyDPIipyYwYP5CIOWe
   BA5N4Hj+T2WicHwo/hpMLCUoXumSLvJgLtoZcJ5/I6Jf9lYeu5Apk0jIO
   Kwr3hWEnqlwKwDTOly+JV0GTC8JBFuWdo5BuCN0xMWPiSRSHeQIgE4tBI
   g==;
IronPort-SDR: 8VQZgGqoUW/ucAmlP5B+/TwT5+0hSPekQSwAtGn2fPOwgKSUJzT86Qd2bi4VP9zqaP3tqBJAQu
 Qa5jBKhyAqQRkOFAD8YZtfssji84m/Js4S4RT8NKdLdLRmbMTnekYA9+xHQ62fHlRoOzqE9Pzc
 KoLi4wujI6qX3W4axpEmjZUJEqmTzmLoLoxDFWlRLGwh34AUCgKQ80zJVTAPqQjMEgUk6QUmYH
 AxIOyGS6I4CiQQ9JEa4l0sGw4T/2ZkvvqB4thabjoJGhaykY2VFdBv6bZyx1X24ODAGd1vbHwM
 nXM=
IronPort-PHdr: =?us-ascii?q?9a23=3AtewmRRNY7DRTivs+hJol6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/39pMbcNUDSrc9gkEXOFd2Cra4d0KyI6euxACQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+NhS7oRveusQSnIdpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLzhSwZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSW?=
 =?us-ascii?q?dHQ81fVTFOApmkYoQAD+QPM+VWoZTjqVQStha+GRWgCfnzxjNUmnP736s32P?=
 =?us-ascii?q?khHwHc2wwgGsoDv3bVrNT0NKcSTOe1x7TLwjXDdfxW2Cr25Y/IcxEgofGDR7?=
 =?us-ascii?q?NwfdbNxUQhDA7Fk0mfqZb/MzyLy+sNrnGW4ux9Xuysk24qsx99riSry8s2iY?=
 =?us-ascii?q?TEhpgZxk3F+Ch72oo4J8G0RUhmatC+CpRQrTuVN45uT8MnRGFnpTg1x6UduZ?=
 =?us-ascii?q?6+YCgK0JMnxwPDa/Cfc4iH/BbjVOGJLDd9nn1leba/iw+28Uiu1+HwT8e03V?=
 =?us-ascii?q?RWoiZfndnMsXcN1xPX6seZUPdy4kCh2TOX2wDS7OFLP1w0mLLFJ5I9xrM8jJ?=
 =?us-ascii?q?kevETZEiPrmUj7jrWae0c49uSw7uToeLTmppuSN49ujQH+N7wjm8y+AOQ4KA?=
 =?us-ascii?q?cOXnSX9fiy2bD44E32XK9KguconabErZDWPd4bqbKhAw9JzoYj7A6yDzOn0N?=
 =?us-ascii?q?QegHkGI0tJeRyGj4jzJV7OJO73Deykg1m3jjdryO7JPqf7DpXOMHfDirHhcq?=
 =?us-ascii?q?h560JGzwoz199ftNpoDeQjJ/L6XEn8r5TyAwU2e1i2xObuDtNwzcUUVHiAKq?=
 =?us-ascii?q?6fLK7W91SP47Rra8SJYYYTpTv5Y9c/+vvkhHQ50QsQeKyg24YabDa3BOljKU?=
 =?us-ascii?q?ySYVLthMsMFSEBuQ9oCKTOlVaLGRVUanKyWOpo4iwwCYugCsHIQY2pgLup3S?=
 =?us-ascii?q?GnE5kQbWdDXBTEMHH0eoHMf/YKdTLaHc57nzgJTqPpH4sg0wy+qw70ypJmKP?=
 =?us-ascii?q?bZ/msTspe1kJBW7unXmFkM/DhzR5CezWiJSEl/mW8FTiIs27p250tnxQHHme?=
 =?us-ascii?q?JUiuJZGZRoobtsUwM+OISWh7h2As7/XyrNd8mETVKhTMngBzwtGJZ56sEPbE?=
 =?us-ascii?q?98H52NlBHFxDanArldw7WVBZM986aa0GLwId1hxnfA/Kgnk1QiBMBIMDvizo?=
 =?us-ascii?q?529g2bK5TEgkuEjL3iIaQV3SuL+H2O3GSTp1pwUQhsXKGDVncaMA+eqdX/+1?=
 =?us-ascii?q?OHUL60BLAqKRBp18GPMO1JZ8fvgFEAQ+3sfJzYbn69lnmYGxmF3PWPYZDsdm?=
 =?us-ascii?q?Fb2z/STAAAkgYO7TOFOBI4CyOJvW3TFnptGEjpbkeq9vNx+12hSUph/gCYb1?=
 =?us-ascii?q?Bmn4i18x9d0e2OS/oShupfkDoqsXN5EEvrjIGeMMaJuwc0JPYUWtg6+loSkD?=
 =?us-ascii?q?uB7wE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E1AwB/up5dgEanVdFlhlKETY5bhRc?=
 =?us-ascii?q?BmB0BCAEBAQ4vAQGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjo?=
 =?us-ascii?q?pAYNVEXwPAiYCJBIBBQEiATSFeKRCgQM8iyaBMoQMAYRYAQkNgUgSeiiMDoI?=
 =?us-ascii?q?XgRGDUIQogyqCXgSBOQEBAZUvllcBBgKCEBSMVIhFG4IqlxaOLZlPDyOBRoF?=
 =?us-ascii?q?7MxolfwZngU9PEBSPXgFWJJFLAQE?=
X-IPAS-Result: =?us-ascii?q?A2E1AwB/up5dgEanVdFlhlKETY5bhRcBmB0BCAEBAQ4vA?=
 =?us-ascii?q?QGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjopAYNVEXwPAiYCJ?=
 =?us-ascii?q?BIBBQEiATSFeKRCgQM8iyaBMoQMAYRYAQkNgUgSeiiMDoIXgRGDUIQogyqCX?=
 =?us-ascii?q?gSBOQEBAZUvllcBBgKCEBSMVIhFG4IqlxaOLZlPDyOBRoF7MxolfwZngU9PE?=
 =?us-ascii?q?BSPXgFWJJFLAQE?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="14126547"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 22:03:10 -0700
Received: by mail-lf1-f70.google.com with SMTP id w22so1056686lfe.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 22:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6pAAPXZ1XbspBXsT/nVNYN754RlatzoTXF5DnMyqcQU=;
        b=HgqnchIeZZxieR5cLX0Yqs1iOj6th+7r77czKrzEp7LJvNp1b8dFfEpVQo78tAibFN
         WnDYnJD+TKqRN6N3VTuhXRdiVIMMw7KN3/v+Sjlw7cXcOep1Vtnqv+4DQZXS+IOKBfHQ
         J0GC3WR9vPmDoX2jLeOIwwO3HTPgx6ccOtEs5gg+KoxcUQ8zkhflljKWClLxHTJjf2yi
         C1MpDe1CAlFGbDX+bduxzeB/AN+Wvk5/AjoOMCvjNxIQCyVjlJRGeLoxZsO4HG++yzou
         L6Ss9qwAiO6vxqFjzC5fYG13nqwG7g2PeX8f/achcTcq5Yu9d1ihgbKa7qOWCX93ngg3
         rn+A==
X-Gm-Message-State: APjAAAUFKzBWueSNwKj80M6Fnf+IykeaDdrxNBBXKyJrMz8dPY2HjHo2
        t+hR9T2moav38XWrStEfOoFOhp4ZGuHRlVdTuXv+XkgbvdZ6V4xwEEZiHlAzogGHaeHZOYw/FU8
        JkAJm5zITR4hTiImR1fe/9hjbmtgNoGpCxxYPLqje7V3K
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr4816419ljj.104.1570683789501;
        Wed, 09 Oct 2019 22:03:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLbyF0nKrTc3N1NhrBYGj51/xn4jBAjuUiVfEPkbcB6vQTEAA65Ud8oPAk9dQ6WUgeoAyg9+sMf/8vTtEysGQ=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr4816390ljj.104.1570683789247;
 Wed, 09 Oct 2019 22:03:09 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 22:02:43 -0700
Message-ID: <CABvMjLThWpQYir0soRDE3W4S6q0S28RTxen8Y-2YAxbRczMCiA@mail.gmail.com>
Subject: Potential NULL pointer deference in iwlwifi: mvm
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Avigail Grinstein <avigail.grinstein@intel.com>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All:

drivers/net/wireless/intel/iwlwifi/mvm/power.c:

The function iwl_mvm_vif_from_mac80211() could return NULL,
but some callers in this file does not check the return value while
directly dereference it, which seems potentially unsafe.
Such callers include iwl_mvm_update_d0i3_power_mode(),
iwl_mvm_power_configure_uapsd(),
iwl_mvm_power_allow_uapsd(), etc.



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
