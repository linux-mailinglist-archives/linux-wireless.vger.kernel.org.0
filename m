Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0366A9BF5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfIEHhG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 03:37:06 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48851 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730809AbfIEHhG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 03:37:06 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2816B7B9;
        Thu,  5 Sep 2019 03:37:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 05 Sep 2019 03:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ms9HUSMQgwEBaFLYYsWKEq7yUGv
        U90TU6t4GZB0HnsU=; b=HRdBCTR2/1P5NuKJKWFzJHCW4i1AXKez5LyG5+fbZgW
        hIXxqru5zy8s8LQM2RkrFz86BhHJVPVwVWUJY5k75OLzrouUoK+dXyl7NH6jRBKd
        c6WTv013VkKjlj0TVvf4p6OhwOf5x5Axubt4B7ig1ARtenpv1zP63SWjXeqPgrnj
        i4tNKbI4kZVqw1XRA07Mj8IZZ71LWQ7qjgjA6vGWxLhefSItLqbZPR5Ei7bZkkTm
        BLTagIjC8lucqdVvvVk6ZUgjaxh1Ak4HLO894fP5B6sSDnwCJZK6HxcudIvb/sKn
        FvSbbfWbE2SJ4kgYV1OdLEEQOdElJWlcW33q2Naq6gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ms9HUS
        MQgwEBaFLYYsWKEq7yUGvU90TU6t4GZB0HnsU=; b=wPmD0kuHCKv+1Tm/BuxIlS
        cPj3tGAHCNFxVxf+VlZg0W6dCEQeLTGhNA49K4kvC0P4qCHCiF9Ym63SxQOz1WgL
        3RowvonH3ZRoWayE/XLTQmFT27GKQ9a9XQsXWdc7kP0PeDHo2FZqTOZnNwPmx2Pm
        98R/OZcJrLfh3OGoQO+K3keBHgjmqdBuutgpARtOz1B8Jog3MW3TIS8POB/B9NNE
        3MnEwxnYbfs/FpGMOSNeEGSoxMRu0XeB/SZHcXpfwhuVXccCpmgl57MSX+1y4vSZ
        VcMoEZx3BzB3RkIfiSyquDN8wmG5dyeX4Bn1NtjwfIt4yqtTTnOl488AC7jbCbNA
        ==
X-ME-Sender: <xms:HrtwXXkup2N1uuKdmKnzoEA_7p1-JJN8NQe-_TSZtoHeqaxRp1KF3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesth
    dtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtgho
    mheqnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:HrtwXRbAww2rgi9tiP6C1V4TrspSZ65cf7ly2V839tbcdJCK4ZK9Qw>
    <xmx:HrtwXa25vVRoNRdMdCygr9_sh0fwhVI2wG4brMzTzYSBALpdWMID_Q>
    <xmx:HrtwXRpeSsgR7XIxn6Ab0BeSDk4X1YsXk9JovxyrFLDeL3IQBVCi0Q>
    <xmx:HrtwXbWF9L82id3fLfOV7nSJWVzKy0F9RD1JBbiI02PROPkl0nevDg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4844ED60063;
        Thu,  5 Sep 2019 03:37:02 -0400 (EDT)
Date:   Thu, 5 Sep 2019 09:37:00 +0200
From:   Greg KH <greg@kroah.com>
To:     Ajay.Kathat@microchip.com
Cc:     Eugen.Hristev@microchip.com, Adham.Abozaeid@microchip.com,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: dt-bindings: wilc1000: add optional rtc_clk
 property
Message-ID: <20190905073700.GA30339@kroah.com>
References: <1567603548-13355-1-git-send-email-eugen.hristev@microchip.com>
 <da5ea898-d8da-a6e2-97a0-4662b7d70b31@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5ea898-d8da-a6e2-97a0-4662b7d70b31@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 05, 2019 at 06:09:43AM +0000, Ajay.Kathat@microchip.com wrote:
> Hi Eugen,
> 
> On 04-Sep-19 7:03 PM, Eugen Hristev - M18282 wrote:
> > From: Eugen Hristev <eugen.hristev@microchip.com>
> > 
> > Add bindings for optional rtc clock pin.
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Thanks for sending the patch series. The changes in this series looks
> good to me.
> 
> Acked-by: Ajay Singh <ajay.kathat@microchip.com>

This is good, but, you are adding new features to the driver, when it is
still in the staging directory.  What's the plan on getting it out of
here?  What is left to do?

thanks,

greg k-h
