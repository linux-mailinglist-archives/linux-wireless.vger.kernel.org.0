Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 402A2B8240
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 22:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392499AbfISUKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 16:10:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42038 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390722AbfISUKE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 16:10:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so4407199wrw.9
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 13:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHeQq1OgSuiJCgnR4izjlm0qOPpQ+aHJoD/bGPJ/dHE=;
        b=EX0cBbZj+h8ej2P2WOqWVgao9QfL9V6L2V1VuBKfElGcEaC36OI0jcxp5fXtgwPGxS
         Wdn/ot+YfxWYzMUTNQ7XW9d0WAoYEbnW6l/STf4AHNIlNS+TRBf/P0kpQrPGsMogKvJx
         BKoXEJxdU8tXjnrNL0xrkkRbpf02Kch64OfxLZ3V5XgMrXB33q3rJ92MSvEBAcGW5x+n
         RsYmBpIWfCBl224uYzrc1bYEfd+IKD14X0U8eej3AA8NZ0GwV41PW9gcrldFSS8RalaS
         ixTP3aBAlYjvajLPb1ATjnYbia7R6bXerok00PngQE9IH1SOH+DiK8qH4/Drut/O1qOw
         A+Tw==
X-Gm-Message-State: APjAAAUF6iAD3CUlksd3juvkfAIXcpSli8pBazzH9xqacbVmkpnPOmnJ
        A8ypMhxwd/9VAdOooy+ziOQfnURA8TTuannrZqs=
X-Google-Smtp-Source: APXvYqzgqu7UeCR7F3gWLvOekV2bCaevGJ4n0xrrlLs7dYm/tjucpT9INpdv7n7/PEyL0dZTFeYAh6zGqmFJLMYoi88=
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr8345945wru.12.1568923802485;
 Thu, 19 Sep 2019 13:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1> <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com>
 <879913e9-4254-1381-07f6-d860fb0b8de0@candelatech.com> <f9b224a0-305f-9715-f627-7a5fae0988d3@eero.com>
 <df105ac6-833b-4a22-9ecc-484513a2eb9c@eero.com> <CAA93jw4F4vuXdWOne_A=h6x-ERMshw5B5UqxU1-ZrnD74nAavw@mail.gmail.com>
In-Reply-To: <CAA93jw4F4vuXdWOne_A=h6x-ERMshw5B5UqxU1-ZrnD74nAavw@mail.gmail.com>
From:   John Yates <john@yates-sheets.org>
Date:   Thu, 19 Sep 2019 16:09:50 -0400
Message-ID: <CAJnXXoj_jinaOhxxJP3EpfWsTuaLCR_gREXxqtktPbEAginLjg@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH RFC/RFT 4/4] mac80211: Apply
 Airtime-based Queue Limit (AQL) on packet dequeue
To:     Dave Taht <dave.taht@gmail.com>
Cc:     Peter Oh <peter.oh@eero.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        John Crispin <john@phrozen.org>,
        Ben Greear <greearb@candelatech.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 19, 2019 at 2:18 PM Dave Taht <dave.taht@gmail.com> wrote:
>
> For the record, this was the google report on their implementation in 3.18.
>
> http://flent-newark.bufferbloat.net/~d/Airtime%20based%20queue%20limit%20for%20FQ_CoDel%20in%20wireless%20interface.pdf

From skimming that paper it sounds like this is shipping
in the current Google WiFi product.  Is that correct?

/john
