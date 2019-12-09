Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE8117291
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 18:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfLIRPH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 12:15:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50228 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbfLIRPH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 12:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575911706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0np/OpvT0g5R1vazLaF9Av5sXjYu6s6NyCQldgQIZC4=;
        b=gLJFvYAsDFuykoNSQLxcE+G6z19uKQxIxhn71jviipLI/Q2o2CIyGZ92UsdagUFtSA8R6h
        0rMcwkbF0d8w6bdWmVCtobu7rExaaMTcWalqIztJilgQkYGx/3cvB5DRIpmXuuJazCX0JP
        LOgz8Hkl0WmA4mevqeckyNsc9mwSyko=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-ams3EQQMMxuUkp3q_v3Edw-1; Mon, 09 Dec 2019 12:15:05 -0500
Received: by mail-lf1-f72.google.com with SMTP id c16so2621026lfm.10
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 09:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0np/OpvT0g5R1vazLaF9Av5sXjYu6s6NyCQldgQIZC4=;
        b=BBRQtFxe/PhI0Ru8QzDVsyeLn3y1ukRhbMyR1Sv5Oq5SVmcoqoJupczigRa/1qUL0T
         tUY7eMikTM1AfnOlbpCIgNyisdGu9dFCf6s7rZ+PmRdjDHxV+BbHJMjMs6L5wEIsC/pv
         iretLQHSQhMh5oKyzdRbzuROD5SfQ8kqMXifl64a5ESq0mCSAqOoXIoMIL3IItEgbToY
         JPGxVrXaZ9WAiljtJby5mTU+/vjP2pb8VKfVLrty+ABAiiGr0xrnHob9um60nsmkRn4T
         8oBUhAZZTPzvtyzjWMB9jFn3UJZE3EXL0wqoDFLEF57IVWEuhXDL7PeS9wMP2Gj4MQWW
         xKNA==
X-Gm-Message-State: APjAAAVdL6trq2rTz4yeK+Cf0sWcpreZCcKa4GK4+roQ+81/1hQKEELp
        3SgA9u0UeYo85GnS87QHwexJtQkaQsnonSm7FSD4ahwpb+761g/Tx7rlSjIOZtCf6gJ8+Ah7xVc
        qcjxiGKjjGaCnf4SgA1t9//fcvGM=
X-Received: by 2002:a2e:294e:: with SMTP id u75mr17692724lje.173.1575911703591;
        Mon, 09 Dec 2019 09:15:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/pf4NtwNUb6D7THW/oElUWEomYqjhAyi3kRgv9z9SizTF9nsF7C4VDLA5/sQ/ZUuDeiKsDQ==
X-Received: by 2002:a2e:294e:: with SMTP id u75mr17692708lje.173.1575911703461;
        Mon, 09 Dec 2019 09:15:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a24sm229079ljp.97.2019.12.09.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 09:15:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BE52F181938; Mon,  9 Dec 2019 18:15:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mt76: rely on mac80211 utility routines to compute airtime
In-Reply-To: <4cf6ef6374473df1b79ca8cc4ab8b431e0789c84.1575910106.git.lorenzo@kernel.org>
References: <4cf6ef6374473df1b79ca8cc4ab8b431e0789c84.1575910106.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Dec 2019 18:15:01 +0100
Message-ID: <8736dtifoq.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: ams3EQQMMxuUkp3q_v3Edw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Rely on mac80211 airitme utility routines and remove mt76 duplicated code
> to estimate tx/rx airtime
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Thanks for taking care of this.

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

