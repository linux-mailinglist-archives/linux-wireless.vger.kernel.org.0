Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3001E2236
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgEZMrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 08:47:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41905 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgEZMrp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 08:47:45 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jdYzf-0001sy-DU
        for linux-wireless@vger.kernel.org; Tue, 26 May 2020 12:47:43 +0000
Received: by mail-io1-f70.google.com with SMTP id y6so14305631iol.12
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 05:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fxNtlVS9/0/8nWswENbYmWwTRCbTTW7BUKVtpfLaswk=;
        b=UT21TDk9jx3JU6vVTjX1Z28Vv2mjGfIgVFLyISDyrZq/T27mFQWI78tUb2Izosu5jy
         DhNNNd2+Qfw8e6n78V8qBN4mpEmG5gEoaOT8iOyNDqOijSX6FnDSrKbHnYmIHeQULwlZ
         YvYdF9UkA3phTkQlYPuNhB+hc4UyMO7LbkwCM4dlg0ZVSUkK2YUwQArGOh4aSfZaPIOq
         nMUn9zzp6ZomiIdu/pc24lwW/2pJJee2tehS4g2fYALVBCD4j0TZW4NE6+L1O+wZRjfv
         z4SSYdoFt1Uz3a6FCvsf+2zds8ACqOyfHPd6Z3y4FAgRcOINZG8x1rs0DabHDLzk9AwX
         Rfkw==
X-Gm-Message-State: AOAM530LLBz2frCxxAiZYPgUHT17E48NlBjN4wbCpxVOo6UdHMgWsfSk
        ZUSshREjT05THHi4zLnBQnZWNzMZ0a3RrOuRduMx3cGUXGOcT1kXOo7L82rEXYzuT4YMBig6Ic0
        ed5NnvO8XwXGAQS3+P7UoohAV/7pOl1ACxSHp8hvRAtSU
X-Received: by 2002:a05:6e02:f4e:: with SMTP id y14mr898479ilj.165.1590497262396;
        Tue, 26 May 2020 05:47:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmlu5i5RsqX5vVs363lGQdjKag/c8luCnc7o5MZhUfEkSH+s8IG0DDEgFWP8BNDclMPXhaeg==
X-Received: by 2002:a05:6e02:f4e:: with SMTP id y14mr898461ilj.165.1590497262155;
        Tue, 26 May 2020 05:47:42 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:24cd:5f98:9b84:bcac])
        by smtp.gmail.com with ESMTPSA id z12sm4472585iol.15.2020.05.26.05.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 05:47:41 -0700 (PDT)
Date:   Tue, 26 May 2020 07:47:40 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Ahmed Kamal <email.ahmedkamal@googlemail.com>
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Subject: Re: [wireless-regdb] Request for Update regulatory rules for Egypt
 (EG)
Message-ID: <20200526124740.GI67695@ubuntu-x1>
References: <CANzjMX45rf28H9jPwqc0Qdo=S1uHipiUd7FoO+17Gr+WB9bq7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANzjMX45rf28H9jPwqc0Qdo=S1uHipiUd7FoO+17Gr+WB9bq7w@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 20, 2020 at 11:16:12PM +0200, Ahmed Kamal wrote:
> Hello,
> 
> This is a request to update Egypt (EG) according to:
> https://www.tra.gov.eg/en/industry/importing-of-equipment/Pages/Regulations-for-use-of-Wireless-Networks-Devices.aspx
> 
> Sorry this is not a patch. Also, I'm not subscribed to either list, so
> not sure if this will work. A confirmation reply, would be
> appreciated. Regards!

Thanks for the email. I will have a look and try to send out a patch
laer today.

Seth
