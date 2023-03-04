Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D326AAB98
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Mar 2023 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjCDRdH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Mar 2023 12:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDRdG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Mar 2023 12:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F93114997
        for <linux-wireless@vger.kernel.org>; Sat,  4 Mar 2023 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677951133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8C4E8+6iQcsMiZcNBt6Y+IC6mvqRzgAKt5X8TXUX9b8=;
        b=IciWeTnZLI7m8PXDg80u1Igw6Krj1fIbgPDptFXSVKMr1Y02AQA1tuQ5JFnhN1TMVDgFqm
        jynEgRsz2K/9CGK8ktVZXCB4XLGajarc/KijEUtjZWVFdm3akPrKHcrvO2RQyvtzjB1Ftq
        750P4gvYagyS0vghROszfolhlbvyofQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-uks-gq19NfSgCSLZZLzdqA-1; Sat, 04 Mar 2023 12:32:11 -0500
X-MC-Unique: uks-gq19NfSgCSLZZLzdqA-1
Received: by mail-pf1-f197.google.com with SMTP id y35-20020a056a00182300b005e8e2c6afe2so3016246pfa.12
        for <linux-wireless@vger.kernel.org>; Sat, 04 Mar 2023 09:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677951131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C4E8+6iQcsMiZcNBt6Y+IC6mvqRzgAKt5X8TXUX9b8=;
        b=QUj/1mwsa66eiST4odWdVBrMMl0EiEw0W3j5EgqZTHOpxCOxW1K4OG19zvXB3855F5
         pXGBFZX9Zd6uORgC9IRFx+i4sWOtk+ggUaoA8jtXD0ONK+JUJN7znKpmZnb95iuN7AwS
         tBegkcC/2f6nz2SNOr5SBhAQU2BtAlFh9R3yBUXSh7s5lRzkekI1ms0xVE645uRdPqCg
         whYygYoStZzAXldrEKKUDX7iLTdbWXQBwMqberBBhNu3DYvdG/+iPc24LRjR4Y2nqg9U
         4E3yFZkN25LCcgqeciXwEQgl38h97Cl8OSJkRCAMmbyA70r4lzdyOWc2IjCo0f1JJBWw
         Z2qA==
X-Gm-Message-State: AO0yUKV94dhtK1I92M737EG5e3FJbC/wJENAlZOlUViQyC1Rq9lwANvp
        GTL1cRJh9lWOCD1DvDEmsU6Nscb47T35ipQMWyz/aw17jLckxOl1f0KY0cvbvYsu2reecjchVGF
        x4zChK1EXnlmBQylU5VVtIUmx6O4=
X-Received: by 2002:a17:902:d509:b0:19c:65bd:d44b with SMTP id b9-20020a170902d50900b0019c65bdd44bmr7115231plg.60.1677951130777;
        Sat, 04 Mar 2023 09:32:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+QCR4bfMyqAtrwBh9+X7iIQ3SyXW6/XHYjPDlHFPnmXU4e1wgUdHGrkkGF7bROUgBmEi97bg==
X-Received: by 2002:a17:902:d509:b0:19c:65bd:d44b with SMTP id b9-20020a170902d50900b0019c65bdd44bmr7115216plg.60.1677951130475;
        Sat, 04 Mar 2023 09:32:10 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id bh9-20020a170902a98900b0019b0937003esm3582167plb.150.2023.03.04.09.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:32:10 -0800 (PST)
Date:   Sun, 5 Mar 2023 02:32:06 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, quic_alokad@quicinc.com,
        quic_msinada@quicinc.com
Subject: Re: WARNING in nla_get_range_unsigned
Message-ID: <ZAOAlpmO+SWq/wAL@kernel-devel>
References: <ZANfZ6wHQOUObgh4@kernel-devel>
 <f8708f82419949fabdf03883c821261c4a45e2b7.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8708f82419949fabdf03883c821261c4a45e2b7.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 04, 2023 at 05:43:12PM +0100, Johannes Berg wrote:
> > 
> > I investigated this issue and found that the issue relates to the
> > following commit:
> > 
> > d7c1a9a0ed18 wifi: nl80211: validate and configure puncturing bitmap
> > 
> 
> There's a fix in the queue for this, I'll get it in soon.
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20230224133656.b53b1fea182c.Ifa95124e8851df90e69776bcc3b0e3ebd1cf1687@changeid/

Thanks for the reply.  I got it.

Shigeru

> 
> johannes
> 

