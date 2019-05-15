Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC351F86A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEOQVr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 12:21:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48644 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfEOQVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 12:21:47 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hQwf3-0008Ir-18
        for linux-wireless@vger.kernel.org; Wed, 15 May 2019 16:21:45 +0000
Received: by mail-it1-f197.google.com with SMTP id m66so534035itm.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 09:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lE7JN5c7wnptAHMLUWHZgJHeniNypHrZWLH6T5Y5zFA=;
        b=UIE7BlBEIvEQmAz0mvh+00FR0X9f4ZfeqtUhkNFI+8QsMjXi24zGjoH0JlS8LDG5Wh
         BPA5CutWbo7i4wDcIpjfMYQYAUbyMoa2vPMVil4bCnNmODgpvTpqb1Hk8k06q1Wj8IZK
         cSKq3bch0t2JwOuGsZkHhEBquULu8AV1IQ71gTEM9p3YnmQRH3ZsCV/fegfRpdNm4qO4
         AiHDW5x5AEESzdUnlqUwfbaCL1oJOC9kGLxyWUPKbyVUTwnxwLv/dciO/uWbhavRxFeM
         FuT6vN/stoNX1cQyfTWvI/OsJEmgEgybd1nhkdvnAKZNlYWyGOmtvEODErhH+EXAKbcp
         sloQ==
X-Gm-Message-State: APjAAAUfiXg2M6J5ELV6zRjsGSJ2H6x1hYZE6moq9PD3NiyP/e2/xubX
        pC92EXSSQlUr3lIXDMH86EMCHEVxcCUYZW318k5vN4ywynSL+stnsc7gn8lCMBxerL0vK5rFqTW
        hDXC63hMJzrgotCRLLZiB33hcsHMMnm3wznJSQAuifntD
X-Received: by 2002:a02:3ecb:: with SMTP id s194mr28673598jas.29.1557937303993;
        Wed, 15 May 2019 09:21:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwp/P6dxg3KGgewu++4eiC+EBwXLVn5PLRMvdwaqOciOfSMXAVPW6pBRJN/904A5FNCo0nnBw==
X-Received: by 2002:a02:3ecb:: with SMTP id s194mr28673575jas.29.1557937303700;
        Wed, 15 May 2019 09:21:43 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:4dea:9e3c:35e:c3dc])
        by smtp.gmail.com with ESMTPSA id m25sm317591iti.24.2019.05.15.09.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 09:21:42 -0700 (PDT)
Date:   Wed, 15 May 2019 11:21:42 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     suchan <abnoeh@mail.com>
Cc:     wireless-regdb@lists.infradead.org,
        Peter Oh <peter.oh@bowerswilkins.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH v2] wireless-regdb: Update regulatory
 rules for South Korea
Message-ID: <20190515162142.GC4357@ubuntu-xps13>
References: <1556314283-17842-1-git-send-email-peter.oh@bowerswilkins.com>
 <20190515130339.GY4357@ubuntu-xps13>
 <a2fa616d-7829-137c-7f48-6c59974cfa46@mail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2fa616d-7829-137c-7f48-6c59974cfa46@mail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

You dropped Peter and the linux-wireless list from your reply, adding
them back.

On Thu, May 16, 2019 at 12:10:16AM +0900, suchan wrote:
> 
> 2019-05-15 10:03PM at Seth Forshee wrote:
> > 
> > Is there any mention of transmit power control in the document? The fact
> > that some of the old limits are exactly half of they values you've given
> > makes me wonder if they weren't set lower for TPC, especially for
> > 5250-5350 MHz where TPC is common.
> > 
> > Since you're changing these rules, I'd also like to see the frequency
> > ranges changed to match the documented ranges, i.e.:
> > 
> >   2400 - 2483.5
> >   5150 - 5250
> >   5250 - 5350
> >   5470 - 5710
> >   5735 - 5850
> > 
> > I left the gap in the 5470-5850 MHz range since I can't tell exactly
> > where the DFS requirement ends. Usually it seems to be 5725 MHz, but
> > that is not universal. If you can determine where the break is those
> > ranges could also be expanded.
> > 
> > Thanks,
> > Seth
> > 
> > _______________________________________________
> > wireless-regdb mailing list
> > wireless-regdb@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/wireless-regdb
> 
> from same document, just under the table for wifi range itself 5250∼5350
> MHz and 5470∼5725 MHz need TPC and DFS
> 
> TPC rule is if power exceeds 25mW/MHz (this includes antenna gain), it
> has do be able to reduce it under 12.5mW/Mhz.
> 
> DFS rule itself (DFS-JP) looks right.

Thanks! Based on that I think this is probably what we need:

 (2400 - 2483.5 @ 40), (23)
 (5150 - 5250 @ 80), (23), AUTO-BW
 (5250 - 5350 @ 80), (20), DFS, AUTO-BW
 (5470 - 5725 @ 160), (20), DFS
 (5725 - 5835 @ 80), (23)

Peter, if that looks good to you please send a v3 patch.

Thanks,
Seth
