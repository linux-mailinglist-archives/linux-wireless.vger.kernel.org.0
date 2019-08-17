Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177589109C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 15:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfHQNp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 09:45:28 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:36392 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfHQNp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 09:45:28 -0400
Received: by mail-qk1-f182.google.com with SMTP id d23so7166883qko.3;
        Sat, 17 Aug 2019 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7f33k6cNPh9WPs6RtCb536b1YPCD3hfQ1lzZVvFxde8=;
        b=Ihr+aV1/pTz7DS+E0ZR9z51XRvhheOluY9f9+MNLcF7uqJ7Xqifla4K1FFqsyE/5PX
         b4pva1CqhfZj7b0QsBnVqKDJa9W1oBrvnxwwjvIHH+kSJ7cZMOIxAZyLuG6RqvMHF9Ow
         hecA5kKRlq+M+ZroCTJMP1EGKSywY2UJQ/cq4ok+w8BSZB04eDCZ5umsQbwRYVdANXQy
         bK+yHVRgNo2/xXD9Bvbc+AuzE6N4tWh9Q5JoBp3tpfV8fofV2QjNz/nEIH4GtjCOIwyx
         5f6xsWnHg2T9Y0adHMh1TOAn/4diswXK1Pji7sgpW3s8E9nnq50he6Zjz4DlkJj5EbWY
         F52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7f33k6cNPh9WPs6RtCb536b1YPCD3hfQ1lzZVvFxde8=;
        b=d3etZ05FcWoJXwjeKu9ezne3A0SbIVrLI+Tgct0PACagZHPeUnUD5NgFwIU7vwW4tK
         kwiZBNSsFxY64Z6/FGjtttcpksm2gLEz/zIwaG9Lyd5DU3tLFQhCiq0Zxs6/a5RdhyRx
         0SSeIfBEZ8WC7aX3/03tztggaiUF/gX1r+yJWLrTCnXHbopn7NepadCpSYHrRTxQMDDE
         IG0w/guB2Xw8iLXDhKwOxbFcBG5XrhlrstaW/BNQjUVX5ubcct/mTWJjEFupOA/MFWBX
         5TO1S2TzPR7/A8izUj5h4nMpbICLLYgIK2orUkrkVB3zFuVDyL2Xj9I1u+Z3/+uPJcnC
         2ebw==
X-Gm-Message-State: APjAAAVX2HaV2Hc5zFLc+CCAQA78oyrU1uw52QJgI3tzFhafydAubw+W
        3JngRBG0V59eaQLRVtYWjWo=
X-Google-Smtp-Source: APXvYqwTqJNQ9+U1rUSxBxmDGP0WXbh0/VWu9YQtT/tDp35V6jyJNfTlP9MAn0wc8XQx48OHq1dA+Q==
X-Received: by 2002:a05:620a:1f0:: with SMTP id x16mr13639499qkn.11.1566049527376;
        Sat, 17 Aug 2019 06:45:27 -0700 (PDT)
Received: from chirva-void (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id o29sm4740250qtf.19.2019.08.17.06.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Aug 2019 06:45:26 -0700 (PDT)
Date:   Sat, 17 Aug 2019 09:45:25 -0400
From:   Stuart Little <achirvasub@gmail.com>
To:     Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
Message-ID: <20190817134525.GA12977@chirva-void>
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
 <87y2zsf9ps.fsf@depni.sinp.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2zsf9ps.fsf@depni.sinp.msu.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Aug 17, 2019 at 11:59:59AM +0300, Serge Belyshev wrote:
> It looks like that:
> 
> commit 4fd445a2c855bbcab81fbe06d110e78dbd974a5b
> Author: Haim Dreyfuss <haim.dreyfuss@intel.com>
> Date:   Thu May 2 11:45:02 2019 +0300
> 
>     iwlwifi: mvm: Add log information about SAR status
>     
>     Inform users when SAR status is changing.
>     
>     Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
>     Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> 
> is the culprit. (manually) reverting it on top of 5.3-rc4 makes
> everything work again.

Revert how?

git revert 4fd445a2c855bbcab81fbe06d110e78dbd974a5b

errors out:

warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 1583 and retry the command.
error: could not revert 4fd445a2c855... iwlwifi: mvm: Add log information about SAR status
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

Making a patch out of the commit with

git format-patch -1 4fd445a2c855bbcab81fbe06d110e78dbd974a5b

and attempting to apply the patch in reverse with

git apply -R --ignore-space-change --ignore-whitespace <patch filename>

also fails:

error: patch failed: drivers/net/wireless/intel/iwlwifi/mvm/fw.c:861
error: drivers/net/wireless/intel/iwlwifi/mvm/fw.c: patch does not apply
error: patch failed: drivers/net/wireless/intel/iwlwifi/mvm/nvm.c:620
error: drivers/net/wireless/intel/iwlwifi/mvm/nvm.c: patch does not apply
