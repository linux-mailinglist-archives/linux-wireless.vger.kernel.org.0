Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6733FF782E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 16:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfKKP6P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 10:58:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41078 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKP6O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 10:58:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so15193893wrm.8
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nL1rheNUN9lEuzzFdb2XL3FRoWR7EojL9bAG+X/nUzQ=;
        b=VmT5fzoAyecLK4EH6hOG9xRKy7oVzN+kb9xbXeMDufKYxOLufv6VieVcQ0keJSzU+a
         gXjOM4j0gdbw1tkbagN7pYhF5iz6tLJYTk+29fOiUhV4FyFRvNkROCP5JkeRwTKxebDD
         6+6gR0NkMT6xRpa0NWw0QUwmaVvzK3SOJVJJ4gwDdCYiZormPY0Lnfrc5rHAJu+ffKEr
         JdzxxG5HVoS87uM8Z5KHAnQyYQZgf3c8uH7ZTF7nOwbiV/Vyj7RsZt1Jli3sW+Qb7tID
         cDY/WOzgWC/86z755064fZXYlaXHSWRRiNr1DC3T2TN1toGhk8XpiPT1GrAhDgbS+0Uh
         dncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nL1rheNUN9lEuzzFdb2XL3FRoWR7EojL9bAG+X/nUzQ=;
        b=Adjsipxi//74zp0BU9aDXJ4bY3KNXDhrx4Iu/hqH+3Vpio2o1LodmwF+W+DIQBM9Ul
         JA8+ty9v29pDSAURpLrZ/vlBvl10Q9AEgHAf2DIbbDQ4H5DDa+t93F0xPP7xEsGGyzF6
         FohGS36PF665Sv1kLhTRmf2RboH8DDo7wYzsfP4ADAWXgI2Fhipe6oUS5tWQSs8LaXY2
         M4fbailU/STcFHer281Edcxp3euUe4+Pr9nz85O2YwioQaDrCq2tUUeYvfZxHkju4pah
         VTTHUGSaF6uYAM5HSWRkJUAh24UtpaZqIdWjygdVk2xY3K7nv9xK3MD8+w41F8oNFaRE
         oCcQ==
X-Gm-Message-State: APjAAAUZAiI+VH7DxL7y1RVJ2cFhprYi71yGXw60i16R4D+Eo6CbtVdZ
        RFV6OUoMMHfQQDK0vWpPVBNy/g==
X-Google-Smtp-Source: APXvYqz23q0Ee6ynwb1+HB2nx2vWKkBUthxwxwYMRVQO2/o/w1xHoSBPCzqRWrRnGenqJWgZ7d4qkA==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr14209726wrx.212.1573487891043;
        Mon, 11 Nov 2019 07:58:11 -0800 (PST)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id 36sm21256930wrj.42.2019.11.11.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:58:10 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:58:09 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtw88: remove duplicated include from ps.c
Message-ID: <20191111155808.GB29052@netronome.com>
References: <20191111033427.122443-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111033427.122443-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 11, 2019 at 03:34:27AM +0000, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

