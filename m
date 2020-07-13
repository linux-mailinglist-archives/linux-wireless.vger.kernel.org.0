Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BB21D543
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2020 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgGMLvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jul 2020 07:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbgGMLvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jul 2020 07:51:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118BC061794
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2020 04:51:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so16725361ejc.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2020 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N/DHlb+/nZGG7qN0r183zUnGDtK3Lw0uwrnh4HpX2MQ=;
        b=K9z4OQXgZqe68WhodObjskXGXhCveTrRy/diBpkEHckhZqpZTCKRqwWhv8gL/c0eJQ
         HE/ddd4Que9btx6TMvG1ZAjd5MQ39PL1LEH6CtGVG0IrQy0m2Ri/anZu1dieNaHGnA5Q
         95BZwQjw2WGS50mSmx9I5AIEuFbYZ51P7KjRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N/DHlb+/nZGG7qN0r183zUnGDtK3Lw0uwrnh4HpX2MQ=;
        b=fsM5fYpjKl9Eg2WqdzoiiDa/cmkYEb0kCnenlRKlqj9TxwxBDBOJ5pms7Flz87FG3w
         P7jAUtryGzDUzi5VWnh2PB9IwVLkItAsvgGN89wlVnVgIjqkX1mDKjKLR4joRfn4IzGL
         W79Zz9xoCek2rfaxygms0V3EuoIXKzZAu+xtVpOIvo5BfgXG981yFYoi+H5iNHxXYwmd
         fdc0g5zFHB8aF4/BJU5ixJ3jJa2ozYWBU92gVwB79KnN0Ugvr9DAEpNygysm3NKxw2Um
         HUwUwrztqAgcJT24n/90W6vV0Eel3NzabCA9lscOv3WIXyn6s4IWNw2+qakFSHn8s8g6
         lD7Q==
X-Gm-Message-State: AOAM531Jk0whUy6YsA+5iIakGv0Ejqj07qz8Q3/+1w/wmnvm+ShCHncp
        iZxvERhURWmo6IemROYPYHzCvT7nWlmFsQ==
X-Google-Smtp-Source: ABdhPJyPC6ve+saeYmK+j2jidO9325RIY86E6K3eIRiMv5vbBmkdi1CVDxd1dgGuDRIoWh87T+IKCQ==
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr78740469ejc.457.1594641098243;
        Mon, 13 Jul 2020 04:51:38 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id s1sm11306128edy.1.2020.07.13.04.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:51:37 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:51:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-wireless@vger.kernel.org
Cc:     Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Don't IWL_WARN on FW reconfiguration
Message-ID: <20200713115137.GA1065134@chrisdown.name>
References: <20191017144841.GA16393@chrisdown.name>
 <20191017145321.GA1609@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191017145321.GA1609@chrisdown.name>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Just to check in again since this is still happening: is this expected?

I expect that if this is IWL_WARN, it should indicate some unexpected or 
non-ideal state, but the card seems to operate just fine afterwards.
