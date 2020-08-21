Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558C324D7C2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHUO64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 10:58:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32031 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbgHUO6z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 10:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598021933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEyCTt1Rp7KVmrjDMekwq02NZnBdfwZKltOjelxL0jQ=;
        b=VKYru0xYtycbr4rsK7Dw9MzZeG3izjg3NtDaYLBYA32h1IaOr4dO3f2hrj2LNdNpB+H7Kc
        Yc8jSt910TIq1mBnf8Va03eglsE14PN9rC6MT+hc+PzgoB1RABAN8LJzoRF7+sdnRHnmY7
        vCURbj7nsvljui5NQ2H7+IR9iJnC6Io=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-6HcigQvwNh2-Qw58lVzQLg-1; Fri, 21 Aug 2020 10:58:52 -0400
X-MC-Unique: 6HcigQvwNh2-Qw58lVzQLg-1
Received: by mail-wr1-f69.google.com with SMTP id g3so489347wrx.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 07:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zEyCTt1Rp7KVmrjDMekwq02NZnBdfwZKltOjelxL0jQ=;
        b=DuPKEz3bowO2Mwvpswk8ZMM7OdyDam2RUURsF78R3X9Tf3amEW9ckLUAHN6YTrl5eB
         bf1fHtQaNHUNb6Lyn3kI4+yUSf2ITE66fvCQsoCcJdUTaBkN49zte5JfKX8OL61vpLil
         faaCUiWi4HAfH0dHYvuAFJGnkkORGznPSAyYcDWwdKgL33lLejwTaCk1N235mB+tgU5/
         xrr/FkJYUuEhGq6UUI/Ygojn7DxMTSw63+xvR7AWeLRFP/ra05vtWsKIr3uKxfN7eOVV
         2bZ/xKEW6OVGH2kYjAd/denKjZLqcYGaV3aSRUGH01RQWV5zga3t3085S3zVI5OpYnCj
         JbBA==
X-Gm-Message-State: AOAM531ygta3Zn3p0D9oTI2y3wFHT4cdJKgvBxVjmHCtaBdrI0IZi12I
        FsxSRqCK9woOiv8NHIxX3vOzGy6WwKFupbaRIj8Nkv3N6CrQQ3XnbnmkjiZ73GVEDy2RWiOk06R
        oyXPJcmUiJf/7yzZKsJdGCXN7Z90=
X-Received: by 2002:adf:82d5:: with SMTP id 79mr2983872wrc.282.1598021930900;
        Fri, 21 Aug 2020 07:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHEZA50MaYDf1ZMKTLkkhZ8m+yXRWsF5AtB6ygY/9o0151vAqv5nrWG5orQFObM5AMjK1dfA==
X-Received: by 2002:adf:82d5:: with SMTP id 79mr2983858wrc.282.1598021930711;
        Fri, 21 Aug 2020 07:58:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p14sm5289182wrx.90.2020.08.21.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:58:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3B4B91816A2; Fri, 21 Aug 2020 16:58:49 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 3/3] mac80211: improve AQL aggregation estimation
 for low data rates
In-Reply-To: <c3c5197f-17f7-4f6b-712f-d7c68f39ae38@dd-wrt.com>
References: <20200813155212.97884-1-nbd@nbd.name>
 <20200813155212.97884-3-nbd@nbd.name>
 <c3c5197f-17f7-4f6b-712f-d7c68f39ae38@dd-wrt.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Aug 2020 16:58:49 +0200
Message-ID: <87tuww2ggm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:

> in my tests the patch series decreases the performance of ath10k 
> chipsets by 50%, even if feature is not enabled.

"even if feature is not enabled" - you mean without the AQL feature bit
set in the driver? That makes no sense...

-Toke

