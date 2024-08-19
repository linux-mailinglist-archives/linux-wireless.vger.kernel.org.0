Return-Path: <linux-wireless+bounces-11602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AAA9565B8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 10:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BFD1C21533
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB4C125;
	Mon, 19 Aug 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyrLWq/5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617C57880
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056782; cv=none; b=Zisrs9/Jd6EMrnFQQI42oIdnnUAtiEP0YoPNIM6BemLYCiyBG9WM3NIeFXpPjNbnzVKYQFtYb9Jvqbgba1Tf/cUBQs2s2nM1gOIGAux9e/i+Wd418VDUAXUD6r9AwsGticfrl5uMyC/uOkvLjO8ti6bfNVntdcjYqpfCEJAiIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056782; c=relaxed/simple;
	bh=SezsD6wctzhE5ibAiR7Co8OV8Nq20DMVEzYF/Mrd4qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laxC3Je002Y13ABOCe34dFix9iwS+48QJZ3RI0rmqzwEtgQsy0A6LPW1HwQC33HWEFrW7qNidGaO4ptU/4jZ+nfreALku8qimP1AYkYSoBqGjNtKB/QlCUEtsHq8XTQ4F8bBNZrxParYW/7BauOxpUPxsP1AKDsk3EJCSfu+U5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyrLWq/5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724056779; x=1755592779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SezsD6wctzhE5ibAiR7Co8OV8Nq20DMVEzYF/Mrd4qM=;
  b=fyrLWq/5jcvDl+cj7czRGZvwZBLJoALvKGcZJIzUbRpY9UP/e6S6SQu/
   pZnzme3G6oVKL4Gz/Qe5jMIKa8xGbSoccBzykHmD/bJZiJ9wAn5tk57aX
   7TQsiQ5xibVNXk4kkV/DnRo/+aOebFjSbeteuoSd8F3w/1zAWs8TBvEQe
   MgEX6rgl2ivgO0eVs7Fi02aYaBwqxm0ZdYQcT7IEaZewTNNfxb2vv+r0Y
   MlrL56ZjLqS9BSSa1YlbN+DaRhhWkxZ9VHQfl0jL9+IMk6eLxOoQQJEij
   qtOFWK/gLqM2kVjlTrqe5lVESzt537aNawl2wCyyZk96my7RfF77bHBjR
   w==;
X-CSE-ConnectionGUID: upf5lLTiQ9ytFgjAL8elqw==
X-CSE-MsgGUID: tmrz4b3gSyGGSiZ7Q/JwvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22463009"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22463009"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:39:39 -0700
X-CSE-ConnectionGUID: HeeD4+zrTemniAvsqJjc2A==
X-CSE-MsgGUID: ao6X4a2yTjaTujyptxxrLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64972046"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Aug 2024 01:39:34 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfxvH-0008oQ-28;
	Mon, 19 Aug 2024 08:39:31 +0000
Date: Mon, 19 Aug 2024 16:39:26 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Chung-Hsien Hsu <stanley.hsu@cypress.com>,
	Carter Chen <carter.chen@infineon.com>,
	Owen Huang <Owen.Huang@infineon.com>, Marek Vasut <marex@denx.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Erick Archer <erick.archer@outlook.com>,
	Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mathias Krause <minipli@grsecurity.net>,
	Matthias Brugger <mbrugger@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev
Subject: Re: [PATCH 2/2] wifi: brcmfmac: add support for CYW55572 PCIe chipset
Message-ID: <202408191646.1lqp64ie-lkp@intel.com>
References: <20240818201533.89669-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818201533.89669-2-marex@denx.de>

Hi Marek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.11-rc4 next-20240819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Vasut/wifi-brcmfmac-add-support-for-CYW55572-PCIe-chipset/20240819-041807
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240818201533.89669-2-marex%40denx.de
patch subject: [PATCH 2/2] wifi: brcmfmac: add support for CYW55572 PCIe chipset
config: loongarch-randconfig-r123-20240819 (https://download.01.org/0day-ci/archive/20240819/202408191646.1lqp64ie-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240819/202408191646.1lqp64ie-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408191646.1lqp64ie-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1664:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] signature @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1664:29: sparse:     expected unsigned int [usertype] signature
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1664:29: sparse:     got restricted __le32 [usertype]
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1665:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] count @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1665:25: sparse:     expected unsigned int [usertype] count
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1665:25: sparse:     got restricted __le32 [usertype]
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1841:40: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1841:40: sparse:     expected unsigned int [usertype] value
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1841:40: sparse:     got restricted __le32 [usertype]

vim +1664 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c

  1649	
  1650	
  1651	static void
  1652	brcmf_pcie_write_rand(struct brcmf_pciedev_info *devinfo, u32 nvram_csm)
  1653	{
  1654		struct brcmf_rand_metadata rand_data;
  1655		u8 rand_buf[BRCMF_ENTROPY_HOST_LEN];
  1656		u32 count = BRCMF_ENTROPY_HOST_LEN;
  1657		u32 address;
  1658	
  1659		address = devinfo->ci->rambase +
  1660			  (devinfo->ci->ramsize - BRCMF_NVRAM_OFFSET_TCM) -
  1661			  ((nvram_csm & 0xffff) * BRCMF_NVRAM_COMPRS_FACTOR) -
  1662			  sizeof(rand_data);
  1663		memset(rand_buf, 0, BRCMF_ENTROPY_HOST_LEN);
> 1664		rand_data.signature = cpu_to_le32(BRCMF_NVRAM_RNG_SIGNATURE);
> 1665		rand_data.count = cpu_to_le32(count);
  1666		memcpy_toio(devinfo->tcm + address, &rand_data, sizeof(rand_data));
  1667		address -= count;
  1668		get_random_bytes(rand_buf, count);
  1669		memcpy_toio(devinfo->tcm + address, rand_buf, count);
  1670	}
  1671	
  1672	static int
  1673	brcmf_pcie_init_share_ram_info(struct brcmf_pciedev_info *devinfo,
  1674				       u32 sharedram_addr)
  1675	{
  1676		struct brcmf_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
  1677		struct brcmf_pcie_shared_info *shared;
  1678		u32 addr;
  1679	
  1680		shared = &devinfo->shared;
  1681		shared->tcm_base_address = sharedram_addr;
  1682	
  1683		shared->flags = brcmf_pcie_read_tcm32(devinfo, sharedram_addr);
  1684		shared->version = (u8)(shared->flags & BRCMF_PCIE_SHARED_VERSION_MASK);
  1685		brcmf_dbg(PCIE, "PCIe protocol version %d\n", shared->version);
  1686		if ((shared->version > BRCMF_PCIE_MAX_SHARED_VERSION) ||
  1687		    (shared->version < BRCMF_PCIE_MIN_SHARED_VERSION)) {
  1688			brcmf_err(bus, "Unsupported PCIE version %d\n",
  1689				  shared->version);
  1690			return -EINVAL;
  1691		}
  1692	
  1693		/* check firmware support dma indicies */
  1694		if (shared->flags & BRCMF_PCIE_SHARED_DMA_INDEX) {
  1695			if (shared->flags & BRCMF_PCIE_SHARED_DMA_2B_IDX)
  1696				devinfo->dma_idx_sz = sizeof(u16);
  1697			else
  1698				devinfo->dma_idx_sz = sizeof(u32);
  1699		}
  1700	
  1701		addr = sharedram_addr + BRCMF_SHARED_MAX_RXBUFPOST_OFFSET;
  1702		shared->max_rxbufpost = brcmf_pcie_read_tcm16(devinfo, addr);
  1703		if (shared->max_rxbufpost == 0)
  1704			shared->max_rxbufpost = BRCMF_DEF_MAX_RXBUFPOST;
  1705	
  1706		addr = sharedram_addr + BRCMF_SHARED_RX_DATAOFFSET_OFFSET;
  1707		shared->rx_dataoffset = brcmf_pcie_read_tcm32(devinfo, addr);
  1708	
  1709		addr = sharedram_addr + BRCMF_SHARED_HTOD_MB_DATA_ADDR_OFFSET;
  1710		shared->htod_mb_data_addr = brcmf_pcie_read_tcm32(devinfo, addr);
  1711	
  1712		addr = sharedram_addr + BRCMF_SHARED_DTOH_MB_DATA_ADDR_OFFSET;
  1713		shared->dtoh_mb_data_addr = brcmf_pcie_read_tcm32(devinfo, addr);
  1714	
  1715		addr = sharedram_addr + BRCMF_SHARED_RING_INFO_ADDR_OFFSET;
  1716		shared->ring_info_addr = brcmf_pcie_read_tcm32(devinfo, addr);
  1717	
  1718		brcmf_dbg(PCIE, "max rx buf post %d, rx dataoffset %d\n",
  1719			  shared->max_rxbufpost, shared->rx_dataoffset);
  1720	
  1721		brcmf_pcie_bus_console_init(devinfo);
  1722		brcmf_pcie_bus_console_read(devinfo, false);
  1723	
  1724		return 0;
  1725	}
  1726	
  1727	struct brcmf_random_seed_footer {
  1728		__le32 length;
  1729		__le32 magic;
  1730	};
  1731	
  1732	#define BRCMF_RANDOM_SEED_MAGIC		0xfeedc0de
  1733	#define BRCMF_RANDOM_SEED_LENGTH	0x100
  1734	
  1735	static noinline_for_stack void
  1736	brcmf_pcie_provide_random_bytes(struct brcmf_pciedev_info *devinfo, u32 address)
  1737	{
  1738		u8 randbuf[BRCMF_RANDOM_SEED_LENGTH];
  1739	
  1740		get_random_bytes(randbuf, BRCMF_RANDOM_SEED_LENGTH);
  1741		memcpy_toio(devinfo->tcm + address, randbuf, BRCMF_RANDOM_SEED_LENGTH);
  1742	}
  1743	
  1744	static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
  1745						const struct firmware *fw, void *nvram,
  1746						u32 nvram_len)
  1747	{
  1748		struct brcmf_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
  1749		struct trx_header_le *trx = (struct trx_header_le *)fw->data;
  1750		u32 fw_size;
  1751		u32 sharedram_addr;
  1752		u32 sharedram_addr_written;
  1753		u32 loop_counter;
  1754		int err;
  1755		u32 address;
  1756		u32 resetintr;
  1757		u32 nvram_lenw;
  1758		u32 nvram_csm;
  1759	
  1760		brcmf_dbg(PCIE, "Halt ARM.\n");
  1761		err = brcmf_pcie_enter_download_state(devinfo);
  1762		if (err)
  1763			return err;
  1764	
  1765		brcmf_dbg(PCIE, "Download FW %s\n", devinfo->fw_name);
  1766		address = devinfo->ci->rambase;
  1767		fw_size = fw->size;
  1768		if (trx->magic == cpu_to_le32(TRX_MAGIC)) {
  1769			address -= sizeof(struct trx_header_le);
  1770			fw_size = le32_to_cpu(trx->len);
  1771		}
  1772		memcpy_toio(devinfo->tcm + address, (void *)fw->data, fw_size);
  1773	
  1774		resetintr = get_unaligned_le32(fw->data);
  1775		release_firmware(fw);
  1776	
  1777		if (devinfo->ci->blhs) {
  1778			err = devinfo->ci->blhs->post_fwdl(devinfo->ci);
  1779			if (err) {
  1780				brcmf_err(bus, "FW download failed, err=%d\n", err);
  1781				return err;
  1782			}
  1783	
  1784			err = devinfo->ci->blhs->chk_validation(devinfo->ci);
  1785			if (err) {
  1786				brcmf_err(bus, "FW valication failed, err=%d\n", err);
  1787				return err;
  1788			}
  1789		} else {
  1790			/* reset last 4 bytes of RAM address. to be used for shared
  1791			 * area. This identifies when FW is running
  1792			 */
  1793			brcmf_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4, 0);
  1794		}
  1795	
  1796		if (nvram) {
  1797			brcmf_dbg(PCIE, "Download NVRAM %s\n", devinfo->nvram_name);
  1798			address = devinfo->ci->rambase + devinfo->ci->ramsize -
  1799				  nvram_len;
  1800	
  1801			if (devinfo->ci->blhs)
  1802				address -= 4;
  1803			memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
  1804	
  1805			/* Convert nvram_len to words to determine the length token */
  1806			nvram_lenw = nvram_len / 4;
  1807			/* subtract word used to store the token itself on non-blhs devices */
  1808			if (!devinfo->ci->blhs)
  1809				nvram_lenw -= 1;
  1810			nvram_csm = (~nvram_lenw << 16) | (nvram_lenw & 0x0000FFFF);
  1811			brcmf_fw_nvram_free(nvram);
  1812	
  1813			if (devinfo->otp.valid) {
  1814				size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
  1815				struct brcmf_random_seed_footer footer = {
  1816					.length = cpu_to_le32(rand_len),
  1817					.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
  1818				};
  1819	
  1820				/* Some Apple chips/firmwares expect a buffer of random
  1821				 * data to be present before NVRAM
  1822				 */
  1823				brcmf_dbg(PCIE, "Download random seed\n");
  1824	
  1825				address -= sizeof(footer);
  1826				memcpy_toio(devinfo->tcm + address, &footer,
  1827					    sizeof(footer));
  1828	
  1829				address -= rand_len;
  1830				brcmf_pcie_provide_random_bytes(devinfo, address);
  1831			}
  1832		} else {
  1833			nvram_csm = 0;
  1834			brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
  1835				  devinfo->nvram_name);
  1836		}
  1837	
  1838		if (devinfo->ci->chip == CY_CC_55572_CHIP_ID) {
  1839			/* Write the length token to the last word of RAM address */
  1840			brcmf_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4,
> 1841					       cpu_to_le32(nvram_csm));
  1842	
  1843			/* Write random numbers to TCM for randomizing heap address */
  1844			brcmf_pcie_write_rand(devinfo, nvram_csm);
  1845		}
  1846	
  1847		sharedram_addr_written = brcmf_pcie_read_ram32(devinfo,
  1848							       devinfo->ci->ramsize -
  1849							       4);
  1850		brcmf_dbg(PCIE, "Bring ARM in running state\n");
  1851		err = brcmf_pcie_exit_download_state(devinfo, resetintr);
  1852		if (err)
  1853			return err;
  1854	
  1855		brcmf_dbg(PCIE, "Wait for FW init\n");
  1856		sharedram_addr = sharedram_addr_written;
  1857		loop_counter = BRCMF_PCIE_FW_UP_TIMEOUT / 50;
  1858		while ((sharedram_addr == sharedram_addr_written) && (loop_counter)) {
  1859			msleep(50);
  1860			sharedram_addr = brcmf_pcie_read_ram32(devinfo,
  1861							       devinfo->ci->ramsize -
  1862							       4);
  1863			loop_counter--;
  1864		}
  1865		if (sharedram_addr == sharedram_addr_written) {
  1866			brcmf_err(bus, "FW failed to initialize\n");
  1867			return -ENODEV;
  1868		}
  1869		if (sharedram_addr < devinfo->ci->rambase ||
  1870		    sharedram_addr >= devinfo->ci->rambase + devinfo->ci->ramsize) {
  1871			brcmf_err(bus, "Invalid shared RAM address 0x%08x\n",
  1872				  sharedram_addr);
  1873			return -ENODEV;
  1874		}
  1875		brcmf_dbg(PCIE, "Shared RAM addr: 0x%08x\n", sharedram_addr);
  1876	
  1877		return (brcmf_pcie_init_share_ram_info(devinfo, sharedram_addr));
  1878	}
  1879	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

