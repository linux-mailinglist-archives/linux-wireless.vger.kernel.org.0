Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FF637FDAC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhEMS5V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 14:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhEMS5V (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 14:57:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3E36613DF;
        Thu, 13 May 2021 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620932171;
        bh=YB+x1uWJJXbxDHCJJWi/oKYLuH4rg7wMjIce54jHnIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ll+Ro1CUt0ktrq8IuZtyJTBkD88MPjAFHtliBR9Fvw1qA3ThF58w3RwaknULOiyh
         AxpaJo3NhPFnp+zzKjlQOtNqG0KXNvW/CfEf8a0el4Qq+SBwa1A+47J8xD0WmqhEih
         SC1DLw0qbvwrEgoHOuB4xuYuAFuPfSojx/HDq12I=
Date:   Thu, 13 May 2021 20:56:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org, johannes.berg@intel.com,
        tomas.winkler@intel.com, luciano.coelho@intel.com,
        Ayala Beker <ayala.beker@intel.com>
Subject: Re: [PATCH v2 2/3] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Message-ID: <YJ12SaLoO40u3lG5@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210420172755.12178-1-emmanuel.grumbach@intel.com>
 <20210420172755.12178-2-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420172755.12178-2-emmanuel.grumbach@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 20, 2021 at 08:27:54PM +0300, Emmanuel Grumbach wrote:
> +#define ROUND_UP_TO(x, y) (((x) + (y) - 1) / (y) * (y))

What's wrong with roundup() that the kernel provides?

Please don't reinvent things we already have :(

thanks,

greg k-h
