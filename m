Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695F9241900
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Aug 2020 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgHKJjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Aug 2020 05:39:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52578 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728383AbgHKJjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Aug 2020 05:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597138760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQnnA5P7urdaAOkXRZRp7WtybJHnzZYmLJiaJkgBZUk=;
        b=WGSFsTfF6TJrkN7F8We1UMf7XtcI9YnzupF311BYK+BiwJmMYWPBTsVClbxnw3XrkYlHyk
        +hmhuOyr6w+W9lR8FpqBNWtDuk4/7X3JdP+eRWk9VyW//KOWND6c0QsNKGViVQCeHnRjc3
        +/xXEE985CPs3KtN0ZnJaGH9d6wrgvo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-mO42PxvXMWm4iR7-X_zwMQ-1; Tue, 11 Aug 2020 05:39:18 -0400
X-MC-Unique: mO42PxvXMWm4iR7-X_zwMQ-1
Received: by mail-wr1-f71.google.com with SMTP id j2so5395714wrr.14
        for <linux-wireless@vger.kernel.org>; Tue, 11 Aug 2020 02:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WQnnA5P7urdaAOkXRZRp7WtybJHnzZYmLJiaJkgBZUk=;
        b=lfqPOWkr6DvDmAd0DWLgvefjY1nVaQcBCiInzd9XkTwC3YGaD6iqHkEIC3YOjoYOmy
         6bq1EWXbSVGXKmXwAhvmsGAk0M2k82YDfog+xGkmqQYkaOjd4horGXM2UJMk0/ODOHlp
         4YEDhh043QTBJUzxOvEtQqaQ8nwuc7oPXkf+D2vt0jVQxaKhU7W9JdPeWQW9102G7I5g
         SdhqD1PUCBkR7+Kvxj/1XL5HLlhwvhQOCve7/6s7cF4uq52jFj6OP5fWUukcdpaieT8F
         7r1WZX6JDqo+KH963GmSjpdPXVFVfhBepVzaH1CFdDJLJ6ofgzd9z+tLlwax0KUsK5mL
         yWrg==
X-Gm-Message-State: AOAM533KqZRwDGIhhuVAShP9EjwL243CWyMuvOBI7i2PVIV/YWpN0EV1
        Ejy753pc8YV70+crnN1EU0kYOT9+Vbi1dB7foht5eaJkqZgbLaZcQ5Rum4M1vfmWCTIFoun8Pi8
        ZDoR6vlldHpNmowpgFwj2Gjz2YRg=
X-Received: by 2002:a1c:c1:: with SMTP id 184mr3403802wma.105.1597138757548;
        Tue, 11 Aug 2020 02:39:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3HXA8xgcuHnQJ3r0+45GK2ASYielG4CPqgQ92Smq0tApUeyPye6vNTufmyESKBCfmhORLtg==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr3403791wma.105.1597138757426;
        Tue, 11 Aug 2020 02:39:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r16sm27925922wrr.13.2020.08.11.02.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 02:39:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 630F118282F; Tue, 11 Aug 2020 11:39:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/2] mac80211: calculcate skb hash early when using itxq
In-Reply-To: <20200726130947.88145-2-nbd@nbd.name>
References: <20200726130947.88145-1-nbd@nbd.name> <20200726130947.88145-2-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 11 Aug 2020 11:39:16 +0200
Message-ID: <874kp934jf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> This avoids flow separation issues when using software encryption

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

