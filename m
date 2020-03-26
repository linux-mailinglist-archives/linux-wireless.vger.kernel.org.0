Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0211942F3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgCZPWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 11:22:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41542 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727717AbgCZPWN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 11:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585236131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1OMIcMPeDCWR0QmTQUhozd64vtRTFbHwbh1dfB8B9wI=;
        b=ZqLgMdECcvc0xNP8bRhoA36jydRVTM0hcSZncKBE9syLINuKQe4hb2c6Ox8+3spewGcE+a
        iRjn1/d4goPfDvfyqh3wDx9/4wdgz97a66ar5ZtVjUa5284PijR/1ocZuSGlCnOS1jTQ8+
        OwVT2MB2u0NyvY8voWu1Ys8p4ub5OGY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-ysiEeLlUOWugogXNP6OlTQ-1; Thu, 26 Mar 2020 11:22:10 -0400
X-MC-Unique: ysiEeLlUOWugogXNP6OlTQ-1
Received: by mail-lf1-f71.google.com with SMTP id l7so2379966lfk.8
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 08:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1OMIcMPeDCWR0QmTQUhozd64vtRTFbHwbh1dfB8B9wI=;
        b=uTpwX44loxJvkgD505oICVl5sW0EOcP8aWghonmX8FEHNTr9KZp2loKqrw2y0ck0ki
         JkDHxh0Q1nxJXNpcMR5FGS2YLgPd5/koShdW7IqeCk/Rs1nCNsd+OdHIUWXO6z39yDjZ
         e6kBWfqIDFJSHgKfzP4FRAK8sYhmBXDizAf6RE3qB33u2q2f2Q0DiZt65ccCd6rH3vN0
         veP54CfYkJBf2bD/NSL2Ngu9YskebCMVUjB6A38XNpfZP6gRynErm2n8KoF17AD4ssc8
         Jf4zfHmdSpGi3+ZUn8bHxltJGj+Omg4hqArmkskKA7066Osedm6BrI96G9PI0lvwqrce
         QhlQ==
X-Gm-Message-State: ANhLgQ3pGwJAJsiO6OmM5UzYhLIFJSX0D1OocATNlDG/kl6KxkZ61pE0
        N/Ob0sGxYBD3bEhAraeSy8DnT6eqtLDv8qo1lVkyW4o3LFqk63sj31QVjR1Toe4/Iw69/K2WEfC
        tC8ExIxF1Eg9ySsTMXBQlWdlu5+8=
X-Received: by 2002:a2e:a419:: with SMTP id p25mr5230169ljn.206.1585236127856;
        Thu, 26 Mar 2020 08:22:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypK11efxdwb2eIBAeY1MOLiicdmNzgdTE4XHq5atqlpwmuwG1bzOyWRVyAKcXuXtG2viX7Aw1Q==
X-Received: by 2002:a2e:a419:: with SMTP id p25mr5230151ljn.206.1585236127518;
        Thu, 26 Mar 2020 08:22:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n17sm1639989ljc.76.2020.03.26.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:22:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 958F918158B; Thu, 26 Mar 2020 16:22:04 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mac80211: mark station unauthorized before key removal
In-Reply-To: <20200326155133.ccb4fb0bb356.If48f0f0504efdcf16b8921f48c6d3bb2cb763c99@changeid>
References: <20200326155133.ced84317ea29.I34d4c47cd8cc8a4042b38a76f16a601fbcbfd9b3@changeid> <20200326155133.ccb4fb0bb356.If48f0f0504efdcf16b8921f48c6d3bb2cb763c99@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Mar 2020 16:22:04 +0100
Message-ID: <87369vnntv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> If a station is still marked as authorized, mark it as no longer
> so before removing its keys. This allows frames transmitted to it
> to be rejected, providing additional protection against leaking
> plain text data during the disconnection flow.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

