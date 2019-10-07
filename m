Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91D0CEC9C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 21:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfJGTTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 15:19:33 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:7065 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGTTd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 15:19:33 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 15:19:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570475974; x=1602011974;
  h=mime-version:from:date:message-id:subject:to;
  bh=LHYtmlTgSx58sSJEN4Ghrk7oWWL9DzXHOlkqjGOMe2E=;
  b=Pyq2KuULqm8FiTgT5SObeiIt2EBnvDj53dUMDvVxuttyDs0156v/kE6G
   XBfuosSKXrz/oZEl5oguQnK1n7E61Xkm0/P+VjL40h54dDs+tLajJuuSC
   GTedM7Jc/5u1uEZLbsru44jPDthiG26mycsMOI7ZP7fOB+NrkXUI+mx3b
   3zcIzi8ChkIrYuyskvAa/+OR71440+8r3uLYxVY93ZZZipnH6RSObTrqA
   keV4tWUTN5ehoy5dqvkLj0ip1HAlul+nUMzRNKkD0p65iBHD+iIlMBa7T
   V7ox+Cg9KboTofQMP2CjLZyugo7RPJMJToQvGfBMBLnVf2ByuNm3tvNml
   w==;
IronPort-SDR: I7gZXJUYD5BDfZkXWBOTvqhw4juUPb6bGhevNs+b8f/QqB1J+5Xj/p71kWDeEAXjXh8x1OzYOY
 oicY4BuKmbrKFJwHLJTuhrEtstIjM8rPK4vQO6Dr2vYeZ1StUVQInGa/OZD0bSPgLC1tfoSvn2
 yFg208G4oGM0XpaRIbIO08dgqX+TJW/m0XcIa5mA/syCj8eFLUrPcIgLHViN6C61Nx3um1GG1J
 bdXSsqCzYyIYDp15/KBvz/jt3f2ssEr1AEUV0NzrzOHYxQ7qDBm5Yaf8+1xtF8mgT5/13yJ7CB
 X/Y=
IronPort-PHdr: =?us-ascii?q?9a23=3AGX0QWBGCc7MDfjyv8wMVIZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pc+5bnLW6fgltlLVR4KTs6sC17ON9f2/EjVauN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twXcu8sZjYd/NKo91w?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFKH4GyYJYVD+cZMulWr4fzqVgToxWgGQahH//vxiNSi3PqwaE2z+?=
 =?us-ascii?q?YsHAfb1wIgBdIOt3HUoc33O6cTUOG1zLTIzTLeZPxV2Tfy8onIeQ0mrPCMXL?=
 =?us-ascii?q?NwcdDeyUgzGw/ZgFidspHlMC+P1ugXrWeU8vdgWPuphmU6qA9xuiCiytkwho?=
 =?us-ascii?q?TNnI4YyVDJ+T9nzIopJtC0UlN3bNqgHZZWqiqULZF5Qtk4TGFtoCs6z7oGto?=
 =?us-ascii?q?OlcyUS05QnwgLfa+SAc4iV/hLvTOaRLil8hHJiYL+/ggy98UmkyuHlUsm00k?=
 =?us-ascii?q?tGojNLktXRsn0A0wbf6seASvt68Ueh3SiA2xrP5eFDJEA4javbK5g/zb4sjp?=
 =?us-ascii?q?cfr1jPEyvslEj1jKKabFso9vSr5uj9f7nropuRO5dxig7kM6QunsK/Af4/Mg?=
 =?us-ascii?q?gLR2Wa+eW91L358k34XLlGkvM7n7LEsJ/GP8QXvLC2DBJI0oo78RawEy+m0M?=
 =?us-ascii?q?gEnXkANF9FfBOHj470O1DBOfz5A/a/g06ynzdv2f/GJabhD47TLnjMjrjhZ6?=
 =?us-ascii?q?xx601Cxwopy9BQ+ZZUBqsGIPLpVU+i/ODfWz0+MwWyxev8QP9wzIxWDWCIAq?=
 =?us-ascii?q?afNq7J91WF/O0HIu+QaYtTszH4fbxtyvvrhHkklFtVUrO02JEeY3DwSvljJk?=
 =?us-ascii?q?yffHfoxNgbDGIAtwE+ZO3slFCGFzVUYiD2F4Yh7ThzI4WrCYfEDtSpnbeA1S?=
 =?us-ascii?q?G8WJZRa2RGDXiNF2vlc8OPXPJaLGqzJNNslnQgVL68W8ce1AujsALh0PIzKu?=
 =?us-ascii?q?vS5z0HtJzi/Nlz++DX0xo18GowR+eU12WAB199mmRAEzwo1aR4iUd6xlqKzL?=
 =?us-ascii?q?J/mfUeEsZcsbcBexYzMZeU5eF5Bsq6DgvQd9OADlyrQdi8KTA3Ut81hdQJZh?=
 =?us-ascii?q?A5U+6ihxDKxWKRS5oci72XFZU07+qIxHj4J89njW2A0aA9jkU3S8tSHWygmq?=
 =?us-ascii?q?N7sQPUAtiN236Qja/iTqQVxinLvDOYxHCH+lpYWRR3V43EW2wSYg3dqtGvog?=
 =?us-ascii?q?vGTrmzGfE4MxFMzcOZMYNUZdDzy1ZLXvHuPJLZeW3102G9GRqF2JuSY4fwPW?=
 =?us-ascii?q?YQxiPQDA4DiQ9XtXKHMxUuQySsuWTTCBRwGl/1JUDh6+9zrDW8VEBwhzOKbl?=
 =?us-ascii?q?x80fKM+xcTzaiOS/ICw7QdkCw67Sh/BhCw08+AT5Krpwdnc7RBKeg65lgPgW?=
 =?us-ascii?q?nCsApyFpe7ab1pnBgTfxkh7G300BAiO4RSkdUt5EEqxQs6fbOK0FpAL2vD9Y?=
 =?us-ascii?q?37IPvaJnSkr0PnULLfxlyLiIXewawI8vlt7gy75Aw=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FkAgB6jptdh8fQVdFmDhABBhKFd4R?=
 =?us-ascii?q?NjmCFFwGMUIEYijQBCAEBAQ4vAQGHHyM4EwIDCQEBBQEBAQEBBQQBAQIQAQE?=
 =?us-ascii?q?BCA0JCCmFQII6KQGDVRF8DwImAiQSAQUBIgE0gwCCCwWiboEDPIsmgTKECwE?=
 =?us-ascii?q?BhFYBCQ2BSBJ6KIwOgheBEYNQh1GCWASBOAEBAZUsllQBBgKCEBSMVIhEG4I?=
 =?us-ascii?q?qAZcUjiyZSw8jgUaBezMaJX8GZ4FPTxAUgWmNcQQBViSSHAEB?=
X-IPAS-Result: =?us-ascii?q?A2FkAgB6jptdh8fQVdFmDhABBhKFd4RNjmCFFwGMUIEYi?=
 =?us-ascii?q?jQBCAEBAQ4vAQGHHyM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6K?=
 =?us-ascii?q?QGDVRF8DwImAiQSAQUBIgE0gwCCCwWiboEDPIsmgTKECwEBhFYBCQ2BSBJ6K?=
 =?us-ascii?q?IwOgheBEYNQh1GCWASBOAEBAZUsllQBBgKCEBSMVIhEG4IqAZcUjiyZSw8jg?=
 =?us-ascii?q?UaBezMaJX8GZ4FPTxAUgWmNcQQBViSSHAEB?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="81227560"
Received: from mail-lj1-f199.google.com ([209.85.208.199])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 12:18:31 -0700
Received: by mail-lj1-f199.google.com with SMTP id 5so3798796lje.12
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2019 12:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HOvGdjzdmR9zNG6ZkfBcEllkGY6GoUXzSDLht1mF2WI=;
        b=nBR/jCdHRaLqinD71z9zZRORwyOCP/8xAu0/Ixv1tYxnWz6z9J7O8pgoEf60+pwddp
         xyPP1FQjBFWmuwVBfolBSlzuS4bDWquscsKDJDrCN+2ksLX/jbDM99Ez+CB7umgp9VaM
         79XJXmYH8hIIQhqu1O9HxSCD78ev6y+VS3599sVYSkbBKPstyrFSENeIO+J5+k3uV2OZ
         JGvaM0L+gZdvuELNe6XA68959vrtHuVnW4QsX/y40O4al3u2MFz7hu6RRsums3euSmcv
         vDW7EOQSMX2m6yVVNsOlT33tnmhWUkmGttjUHoK6Oc+TDv/zQIzGng1mDUR4rmlEoI7n
         zohg==
X-Gm-Message-State: APjAAAU98JpbgQom3/44fosQJrjyhjBfk4KOaZukEhNfGnTloPzQAAc8
        HW0hDJMtke+qln4L2PVhVtkxDlhc8sIlVGO0aTj+reg+YbY2BP5az2kIF8aadaOaVsMZsMnKFlx
        KaNbUEAzNnt19OhQ9iBOdNOd3kszyR5udZzGxVEr2b4JH
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr18369577lfm.67.1570475908314;
        Mon, 07 Oct 2019 12:18:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDsm2ohzARraL1dLP+2VP0TkKPuqHmWeU4s0nw0vbJHVPGul4JY6lCMGPAe2OrCXzu0/jcM+Elf0wRZoMMQ8w=
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr18369560lfm.67.1570475908124;
 Mon, 07 Oct 2019 12:18:28 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 12:19:11 -0700
Message-ID: <CABvMjLRhqCAs-r3LA4nX_5tBj=hQeUfb4g5gHf8ghRdwWqKuPA@mail.gmail.com>
Subject: Potential NULL pointer deference in iwlwifi: mvm
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ayala Beker <ayala.beker@intel.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All:

drivers/net/wireless/intel/iwlwifi/mvm/scan.c:

Inside function iwl_mvm_power_ps_disabled_iterator(),
iwl_mvm_vif_from_mac80211()
could return NULL,however, the return value of
iwl_mvm_vif_from_mac80211() is not checked and get
used. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
