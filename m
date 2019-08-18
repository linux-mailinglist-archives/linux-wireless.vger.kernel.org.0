Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53591649
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfHRKzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 06:55:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37026 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRKzd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 06:55:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so11051620qto.4;
        Sun, 18 Aug 2019 03:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JoziMIOxgfc46gepkQ5RoQyq+43sZ90qJzKjRqeCIUI=;
        b=hKJPI+ciWx7o4i5JKfiyPnv2g+P0ZAEN4gHKXtWbzAcfSLnbmyUlpE6HNu9eK/hLrB
         5P+bB6Li9Kpg4VegBogR60XhKNC04lCE4cFIEw77gRFMQDoaZKNX+Iwkdm17G0sCUQa6
         loFPXJYT34VtOakZLlpMra5CqUAHAaBEDJIIti1jmD1pV78HtP6xeRVSlYM8F2HQYjlQ
         iNuqWgI47wQy8hhve/FRMiI5rAoxdusW5fbjBa7+ORH8c2w/MmXlaAMVFOK6xaXCrb2J
         q/1fBOR9ejOMHx/L3icLncOy8zRwFZSnFPsHEQ/ohrxiJUU+iEN/SZ5uUgifj2VE2HWA
         445w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JoziMIOxgfc46gepkQ5RoQyq+43sZ90qJzKjRqeCIUI=;
        b=fRD2CM60Y2M73MI3zpLHJr3EKthrBZB/VIkr/VpP3cOXBYTtmURPIyUHVTkIHVO9fS
         /vAhe6WZFmPaEYQ0Tj5fskjYoL1mqzrPDcHZK/kRExLRu84ef2vBwWFWY7vtZbk/+ijY
         0mzqxkZA0MDCIiHq17WMiw+Ntg7/7dMo6/AF5y2PH3JwmL7B6uVJgIgxy6DIW57ZS+pn
         WmYF6WZDcV/fHTlRd/U75gVhBruwJSsWoDVHUeDKUT7u2ojC3VdmziuXtkKoE3fD3GKV
         ySuJWgopnN8grQTevFDMj1dq3g4zvF8wd618c72qCmWcuH5ivl7K+KM5RrkZqyTsRmY5
         mM1A==
X-Gm-Message-State: APjAAAVFBdJ3hKw7iREPTLqsEyhguvNIeCUFWbfnpGMUCIv1JxPDCXkA
        r90NnbM1OEhSW8c/a+Ch2PA=
X-Google-Smtp-Source: APXvYqxCiQ+rrh7/hesVSdNU25+8/o2nPdIZIt2TcYQr2uvHT/37ROpOGyEzn/6iB5A39XAy8aAtfg==
X-Received: by 2002:a0c:c96a:: with SMTP id v39mr7413650qvj.121.1566125732228;
        Sun, 18 Aug 2019 03:55:32 -0700 (PDT)
Received: from chirva-void (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id d22sm5403671qto.45.2019.08.18.03.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Aug 2019 03:55:31 -0700 (PDT)
Date:   Sun, 18 Aug 2019 06:55:30 -0400
From:   Stuart Little <achirvasub@gmail.com>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
Message-ID: <20190818105530.GA1247@chirva-void>
References: <fd102579-d83d-b86d-e165-8168c74a4bac@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd102579-d83d-b86d-e165-8168c74a4bac@googlemail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Aug 18, 2019 at 09:17:59AM +0100, Chris Clayton wrote:
> 
> 
> On 17/08/2019 22:44, Stuart Little wrote:
> > After some private coaching from Serge Belyshev on git-revert I can confirm that reverting that commit atop the current tree resolves the issue (the wifi card scans for and finds networks just fine, no dmesg errors reported, etc.).
> > 
> 
> I've reported the "Microcode SW error detected" issue too, but, wrongly, only to LKML. I'll point that thread to this
> one. I've also been experiencing my network stopping working after suspend resume, but haven't got round to reporting
> that yet.
> 
> What was the git magic that you acquired to revert the patch, please?
> 

$ git revert <offending commit>

This will fail as noted, but will place in a revert mode where you can fix the errors.

$ git status

will show (it did in my case, for the latest Linux tree at the time I did this) a modified file

drivers/net/wireless/intel/iwlwifi/mvm/fw.c

to be committed without issue and a conflicted file

drivers/net/wireless/intel/iwlwifi/mvm/nvm.c

whose conflicts you have to first resolve.

I then opened that conflicted file in a text editor and simply removed everything between the lines

<<<<<<< HEAD

and 

>>>>>>> parent of 4fd445a2c855... iwlwifi: mvm: Add log information about SAR status

(inclusive). This resolved the conflict, whereupon

$ git revert --continue

and

$ git commit -a

will finish the reversion. 

> > On Sat, Aug 17, 2019 at 11:59:59AM +0300, Serge Belyshev wrote:
> >>
> >>> I am on an Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz running Linux
> >>> x86_64 (Slackware), with a custom-compiled 5.3.0-rc4 (.config
> >>> attached).
> >>>
> >>> I am using the Intel wifi adapter on this machine:
> >>>
> >>> 02:00.0 Network controller: Intel Corporation Device 24fb (rev 10)
> >>>
> >>> with the iwlwifi driver. I am attaching the output to 'lspci -vv -s
> >>> 02:00.0' as the file device-info.
> >>>
> >>> All 5.3.0-rc* versions I have tried (including rc4) cause multiple
> >>> dmesg iwlwifi-related errors (dmesg attached). Examples:
> >>>
> >>> iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> >>> iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000
> >>> iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND
> >>>
> >>
> >> I have my logs filled with similar garbage throughout 5.3-rc*. Also
> >> since 5.3-rcsomething not only it WARNS in dmesg about firmware failure,
> >> but completely stops working after suspend/resume cycle.
> >>
> >> It looks like that:
> >>
> >> commit 4fd445a2c855bbcab81fbe06d110e78dbd974a5b
> >> Author: Haim Dreyfuss <haim.dreyfuss@intel.com>
> >> Date:   Thu May 2 11:45:02 2019 +0300
> >>
> >>     iwlwifi: mvm: Add log information about SAR status
> >>     
> >>     Inform users when SAR status is changing.
> >>     
> >>     Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
> >>     Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> >>
> >>
> >> is the culprit. (manually) reverting it on top of 5.3-rc4 makes
> >> everything work again.
> > 
