Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE118600A
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2020 22:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgCOV37 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Mar 2020 17:29:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31068 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729202AbgCOV37 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Mar 2020 17:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584307798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCZjjXhZtIZTco2GVuY9U8dtD4rKbgr/KTIhT3OsK/I=;
        b=MTniCmoK8te0pj45YyeqTCV3YSQ5yLUYxEuonWQv263mTR4lQv+A9e28nIRp49NFs02EsV
        4oHNqPvN4AhVRUmESBZEiGQXEOp1gDEC65jg8Vizu8Ypt4sm7W/9Ff8cqTM1DAnkTYcT+n
        bHibl88nLQlYqmTS3K0huKNTihQFD34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-4bSSCoquNZ2P3989GY5_Pg-1; Sun, 15 Mar 2020 17:29:54 -0400
X-MC-Unique: 4bSSCoquNZ2P3989GY5_Pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E82BA800D50;
        Sun, 15 Mar 2020 21:29:52 +0000 (UTC)
Received: from elisabeth (ovpn-200-18.brq.redhat.com [10.40.200.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B737B60BFB;
        Sun, 15 Mar 2020 21:29:46 +0000 (UTC)
Date:   Sun, 15 Mar 2020 22:29:38 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     adham.abozaeid@microchip.com, ajay.kathat@microchip.com,
        linux-wireless@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl
Subject: Re: [Outreachy kernel] [PATCH] Staging: wilc1000: cfg80211: Use
 kmemdup instead of kmalloc and memcpy
Message-ID: <20200315222938.23a9faec@elisabeth>
In-Reply-To: <20200313112451.25610-1-shreeya.patel23498@gmail.com>
References: <20200313112451.25610-1-shreeya.patel23498@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 13 Mar 2020 16:54:51 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Replace calls to kmalloc followed by a memcpy with a direct call to
> kmemdup.
> 
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression from,to,size,flag;
> statement S;
> @@
> 
> -  to = \(kmalloc\|kzalloc\)(size,flag);
> +  to = kmemdup(from,size,flag);
>    if (to==NULL || ...) S
> -  memcpy(to, from, size);
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

