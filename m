Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD39491362
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 23:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHQVow (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 17:44:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43140 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfHQVov (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 17:44:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id b11so10056396qtp.10;
        Sat, 17 Aug 2019 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rGZVNzzI2QS9pBDJrmSzrJpDmP6lpWmRUVb2Efgl9B0=;
        b=T6/BaogjPaaXb19WQl/+zmRTwo4/w7wJi9qSyJYQiERnBcmJHMrkh2ijPqmQS2LoDE
         JZdc39dQmFIR8gyWX1eM5zlBd1Hkjd7JLOAO9TIvSSOznDTecyjIUbaeDE6IIcA2LZPJ
         701st/OQk6inNUH2gVZ1zOj6wQmcl9tZX7IPSl4sWtBmGwP4MnNc1JwXwFqMEtomGjhF
         8oQj+40W9OVu11tqkqSErjHMfCzZsQ78ni4+aEM0Il0ts7/Jm0UKM3iD9o9oHSNstkEk
         4+9SLJ2bqcNNevFwpIm9Gx6gtkSoLaWsLYxVBHZCFMdNmxnFavHDVjhgGaHRfUiGrzit
         8G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rGZVNzzI2QS9pBDJrmSzrJpDmP6lpWmRUVb2Efgl9B0=;
        b=MWPM8bJFenl1dwJF9A1RimtGdTkUB5D7V/yr7SJt6eSpc6/khIUMqtmTRLtfqNbxo7
         o43JLez8LlUWxzXxmiy9QHXZ+fOrDnvz5J9t2X+mtFFT1oeMT0f7xstrQdBjl7JkiDg1
         kvqWEEcAZA1Dx8wICdNvv19teGUPjCVG6ylGADxWPGGIKN8nRBmBGdzxWAGI9cwqXD3S
         3kyGv27oEYf31pLsxqPteYlgg76zmHVD1YOt2EOU/HvgRTZ1yIFxQlj2RWSbaNhE5z88
         c/UOxpILAWcU6lkgvi50hPxsTQRRrdRHILHn7NzmXY90vd4HTM3HtJEVME42pKRw6oP/
         UzQw==
X-Gm-Message-State: APjAAAXwOuAh9FG13aYg2TmqL+LcHSLKMzPZQvK0Qoj3q4CPIwfWcRdi
        75RLkfwF5cxuxepPH1wjARs=
X-Google-Smtp-Source: APXvYqxWabgcDCUlAOy2yqUDViVCCuCdplMuOFZM083061gr11Fmt4Cf/3byTNBZ/8qKkT9xraJnSw==
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr15009638qto.249.1566078291017;
        Sat, 17 Aug 2019 14:44:51 -0700 (PDT)
Received: from chirva-slack.chirva-slack (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id s64sm4931431qke.125.2019.08.17.14.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 14:44:50 -0700 (PDT)
Date:   Sat, 17 Aug 2019 17:44:48 -0400
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
Message-ID: <20190817214448.GB1070@chirva-slack.chirva-slack>
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
 <87y2zsf9ps.fsf@depni.sinp.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2zsf9ps.fsf@depni.sinp.msu.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After some private coaching from Serge Belyshev on git-revert I can confirm that reverting that commit atop the current tree resolves the issue (the wifi card scans for and finds networks just fine, no dmesg errors reported, etc.).

On Sat, Aug 17, 2019 at 11:59:59AM +0300, Serge Belyshev wrote:
> 
> > I am on an Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz running Linux
> > x86_64 (Slackware), with a custom-compiled 5.3.0-rc4 (.config
> > attached).
> >
> > I am using the Intel wifi adapter on this machine:
> >
> > 02:00.0 Network controller: Intel Corporation Device 24fb (rev 10)
> >
> > with the iwlwifi driver. I am attaching the output to 'lspci -vv -s
> > 02:00.0' as the file device-info.
> >
> > All 5.3.0-rc* versions I have tried (including rc4) cause multiple
> > dmesg iwlwifi-related errors (dmesg attached). Examples:
> >
> > iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> > iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000
> > iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND
> >
> 
> I have my logs filled with similar garbage throughout 5.3-rc*. Also
> since 5.3-rcsomething not only it WARNS in dmesg about firmware failure,
> but completely stops working after suspend/resume cycle.
> 
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
